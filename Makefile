#
#indx#	Makefile - Compile sshot versions where necessary
#@HDR@	$Id$
#@HDR@
#@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
#@HDR@
#@HDR@	Permission is hereby granted, free of charge, to any person
#@HDR@	obtaining a copy of this software and associated documentation
#@HDR@	files (the "Software"), to deal in the Software without
#@HDR@	restriction, including without limitation the rights to use,
#@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
#@HDR@	sell copies of the Software, and to permit persons to whom
#@HDR@	the Software is furnished to do so, subject to the following
#@HDR@	conditions:
#@HDR@	
#@HDR@	The above copyright notice and this permission notice shall be
#@HDR@	included in all copies or substantial portions of the Software.
#@HDR@	
#@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
#@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
#@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
#@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#@HDR@	OTHER DEALINGS IN THE SOFTWARE.
#
#hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
########################################################################
#doc#	Makefile - Compile sshot versions where necessary.
#doc#	Also commands for bringing various compilers and interpreters
#doc#	onto a Fedora Core machine.  That is not intended to be
#doc#	comprehensive, only a place to start.
########################################################################
PROG=sshot

SOURCE_MARKER=SShot implemented in
SHEBANG_MARKER=bin/make

ALL_SOURCES=$(shell grep -i '$(SOURCE_MARKER) ' $(PROG).* | sed -e 's/:.*//' )
ALL_TITLES=$(shell grep -i '$(SOURCE_MARKER) ' $(ALL_SOURCES) | sed -e 's/:.*$(SOURCE_MARKER) / -t "/' -e 's/ by .*/" /')

TARGETS=$(shell grep -i '$(SHEBANG_MARKER) ' $(ALL_SOURCES) | sed -e 's/:.*//' -e 's/^$(PROG)./$(PROG)_/' )
#TARGETS=$(PROG)_gcc $(PROG)_f $(PROG)_s $(PROG)_cpp $(PROG)_cob $(PROG)_pas $(PROG)_java $(PROG)_rs $(PROG)_adb $(PROG)_sim

RUSTDIR=rust/$(PROG)
PREFERRED_HOST=fs0.brightsands.com
STRIP_SHEBANG=grep -v "$(SHEBANG_MARKER)"
TMP=build

# Versions of software for Fedora
ARCH=x86_64
JAVAVER=11
YABASICRPM=yabasic-2.90.2-1.$(ARCH).rpm
FPCREV=3.2.2
FPCRPM=fpc-$(FPCREV)-1.$(ARCH).rpm
APLVER=apl-1.8
CIMVER=cim-5.1

# Clearly the GNU C compiler has a lot more warning messages than it did when
# cim was developed.
CIM_ARGS=-Wno-builtin-declaration-mismatch -Wno-implicit-function-declaration -Wno-implicit-function-declaration -Wno-implicit-function-declaration -Wno-implicit-int

info:
		@echo -n "'make all' would build the following targets:"
		@echo " $(TARGETS)" | sed -e 's/ /\n    /g'

all:		$(TARGETS)

#		We use .gcc instead of .c because too many compilers use .c as
#		an interim/temporary file and have no compunction about overwriting
#		.c source.
%_gcc:		%.gcc;	$(STRIP_SHEBANG) < $< | gcc -x c - -o $@

#		These are pretty straight forward compilers
%_f:		%.f;	$(STRIP_SHEBANG) < $< | gcc -x f77 - -lgfortran -o $@
%_s:		%.s;	$(STRIP_SHEBANG) < $< | gcc -x assembler -nostdlib - -o $@
%_cpp:		%.cpp;	$(STRIP_SHEBANG) < $< | c++ -x c++ - -o $@
%_cob:		%.cob;	$(STRIP_SHEBANG) < $< | cobc -x -o $@ -

%_sim:		%.sim
		$(STRIP_SHEBANG) < $< > $(TMP).sim
		cim -b '$(CIM_ARGS)' $(TMP).sim -o $@
		rm -f $(TMP).*

%_pas:		%.pas
		$(STRIP_SHEBANG) < $< > $(TMP).pas	# fpc can't take stdin
		fpc $(TMP).pas -o$@	# -o does not work the same way!
		rm -f $(TMP).*

%_adb:		%.adb
		$(STRIP_SHEBANG) < $< > $(TMP).adb
		gnatmake $(TMP).adb
		mv $(TMP) $@
		rm -f $(TMP).*

#		Rust has its own environment and wants to build in a directory
#		with many configuration files.
%_rs:		%.rs
		$(STRIP_SHEBANG) < $< > $(RUSTDIR)/src/main.rs
		cd $(RUSTDIR); cargo build
		cp $(RUSTDIR)/target/release/$(PROG) $@

# There is so much hidden excrement here in something that should be SO
# simple, it's almost as if somebody was trying to make this difficult.
# Things the programmer learned the hard way:
#
# Java-$(JAVAVER), jdk-$(JAVAVER), & jdk-devel-$(JAVAVER) all needed to be installed.
# You can have a program written in the java language act like a script
# by having a "#!/usr/bin/java --source $(JAVAVER)" on the top of it ***UNLESS***
# the name ends in .java which creates the most desceptive error message
# I've ever seen.
#
# In order for "./sshot.java" to do something useful, I have made it a #!
# make script just like the other compiled languages here.  The compilation
# process is VERY simple.  It creates an "executable" which is the same
# file but with the "/bin/make" removed, and then turns on the x-bits.
%_java:		%.java
		$(STRIP_SHEBANG) < $< > $@
		chmod 755 $@

test-$(PROG)_%:	$(PROG)_%
		$<

clean:
		rm -f $(TARGETS) $(PROG) $(TMP).* *.o

$(PROG).tbz2:	Introduction.txt Makefile $(ALL_SOURCES)
		tar cjf $@ $^

$(PROG).pdf:	Introduction.txt $(ALL_SOURCES)
		@[ `hostname` = $(PREFERRED_HOST) ] || echo "$@ must be built on $(PREFERRED_HOST)."
		@[ `hostname` = $(PREFERRED_HOST) ]
		make_pdf_book		-o $@					\
					-t "SShot, a simple game"		\
					-s "in $(words $(ALL_SOURCES)) languages"	\
					Introduction.txt			\
					$(ALL_TITLES)				\
					Makefile


Fedora:
	# Get basics from Fedora repository
	dnf -y install		\
		gcc		\
		algol68g	\
		gcc-c++		\
		gcc-gfortran	\
		gcc-gnat	\
		gcl		\
		gnucobol	\
		ruby		\
		scala		\
		rust cargo	\
		perl		\
		python		\
		tcl		\
		hugs98		\
		golang		\
		swift-lang	\
		java-$(JAVAVER) java-$(JAVAVER)-openjdk java-$(JAVAVER)-openjdk-devel
	#
	# Install yabasic
	#
	dnf -y install https://2484.de/yabasic/download/$(YABASICRPM)
	#
	# Get and build Simula
	#
	mkdir -p /usr/local/archives /usr/local/src
	rm -rf /usr/local/src/$(CIMVER)
	wget -q -O - http://ftp.gnu.org/gnu/cim/$(CIMVER).tar.gz | tar -xz -C /usr/local/src -f -
	cd /usr/local/src/$(CIMVER)/lib; replace ../../lib/ "" -- *
	cd /usr/local/src/$(CIMVER); ./configure --prefix=/usr && make && make install
	ldconfig
	#
	# Get pre-built Free Pascal compiler and install it
	#
	mkdir -p /usr/local/archives/RPMS
	wget -q -O /usr/local/archives/RPMS/$(FPCRPM) https://sourceforge.net/projects/freepascal/files/Linux/$(FPCREV)/$(FPCRPM)/download
	dnf -y install /usr/local/archives/RPMS/$(FPCRPM)
	#
	# Install APL
	#
	rm -rf /usr/local/src/$(APLVER)
	wget -q -O - https://ftp.gnu.org/gnu/apl/$(APLVER).tar.gz | tar xz -C /usr/local/src -f -
	cd /usr/local/src/$(APLVER); ./configure --prefix=/usr CXX_WERROR=no && make && make install

	#
	@echo "Select whatever entry supports java-$(JAVAVER)."
	#
	alternatives --config java
