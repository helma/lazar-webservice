
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = .
topdir = /usr/local/lib/ruby/1.8/i686-linux
hdrdir = $(topdir)
VPATH = $(srcdir):$(topdir):$(hdrdir)
prefix = $(DESTDIR)/usr/local
exec_prefix = $(prefix)
sitedir = $(prefix)/lib/ruby/site_ruby
rubylibdir = $(libdir)/ruby/$(ruby_version)
docdir = $(datarootdir)/doc/$(PACKAGE)
dvidir = $(docdir)
datarootdir = $(prefix)/share
archdir = $(rubylibdir)/$(arch)
sbindir = $(exec_prefix)/sbin
psdir = $(docdir)
localedir = $(datarootdir)/locale
htmldir = $(docdir)
datadir = $(datarootdir)
includedir = $(prefix)/include
infodir = $(datarootdir)/info
sysconfdir = $(prefix)/etc
mandir = $(datarootdir)/man
libdir = $(exec_prefix)/lib
sharedstatedir = $(prefix)/com
oldincludedir = $(DESTDIR)/usr/include
pdfdir = $(docdir)
sitearchdir = $(sitelibdir)/$(sitearch)
bindir = $(exec_prefix)/bin
localstatedir = $(prefix)/var
sitelibdir = $(sitedir)/$(ruby_version)
libexecdir = $(exec_prefix)/libexec

CC = gcc
LIBRUBY = $(LIBRUBY_A)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -Wl,-R -Wl,$(libdir) -L$(libdir) 
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static

RUBY_EXTCONF_H = extconf.h
CFLAGS   =  -fPIC -g -O2 -I/usr/lib/jvm/java-6-sun/include -I/usr/lib/jvm/java-6-sun/include/linux 
INCFLAGS = -I. -I. -I/usr/local/lib/ruby/1.8/i686-linux -I. -I/usr/lib/jvm/java-6-sun/include -I/usr/lib/jvm/java-6-sun/include/linux
DEFS     = -D_FILE_OFFSET_BITS=64
CPPFLAGS = -DRUBY_EXTCONF_H=\"$(RUBY_EXTCONF_H)\"  -D_FILE_OFFSET_BITS=64
CXXFLAGS = $(CFLAGS) 
DLDFLAGS = -L.  -rdynamic -Wl,-export-dynamic  
LDSHARED = $(CC) -shared
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = ruby
RUBY_SO_NAME = ruby
arch = i686-linux
sitearch = i686-linux
ruby_version = 1.8
ruby = /usr/local/bin/ruby
RUBY = $(ruby)
RM = rm -f
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp

#### End of system configuration section. ####

preload = 

libpath = . $(libdir)
LIBPATH =  -L. -L$(libdir) -Wl,-R$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS =   -ldl -lcrypt -lm   -lc
SRCS = riconv.c rjb.c load.c rjbexception.c
OBJS = riconv.o rjb.o load.o rjbexception.o
TARGET = rjbcore
DLLIB = $(TARGET).so
EXTSTATIC = 
STATIC_LIB = 

RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR = /home/ch/lazar-gui.git/vendor/gems/rjb-1.1.3/lib$(target_prefix)
RUBYARCHDIR = /home/ch/lazar-gui.git/vendor/gems/rjb-1.1.3/lib$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).so $(TARGET).il? $(TARGET).tds $(TARGET).map
CLEANOBJS     = *.o *.a *.s[ol] *.pdb *.exp *.bak

all:		$(DLLIB)
static:		$(STATIC_LIB)

clean:
		@-$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean:	clean
		@-$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		@-$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)

realclean:	distclean
install: install-so install-rb

install-so: $(RUBYARCHDIR)
install-so: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB)
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
$(RUBYARCHDIR):
	$(MAKEDIRS) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) -c $<

$(DLLIB): $(OBJS)
	@-$(RM) $@
	$(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)



###
$(OBJS): $(RUBY_EXTCONF_H)

riconv.o : riconv.c jp_co_infoseek_hp_arton_rjb_RBridge.h
rjb.o : rjb.c jp_co_infoseek_hp_arton_rjb_RBridge.h riconv.h rjb.h
rjbexception.o : rjbexception.c jp_co_infoseek_hp_arton_rjb_RBridge.h riconv.h rjb.h
load.o : load.c jp_co_infoseek_hp_arton_rjb_RBridge.h
jp_co_infoseek_hp_arton_rjb_RBridge.h : jniwrap.h ../data/rjb/jp/co/infoseek/hp/arton/rjb/RBridge.class
	javah -classpath ../data/rjb jp.co.infoseek.hp.arton.rjb.RBridge
../data/rjb/jp/co/infoseek/hp/arton/rjb/RBridge.class : RBridge.java
	mkdir -p ../data/rjb/jp/co/infoseek/hp/arton/rjb
	javac -d ../data/rjb RBridge.java
test : rjbcore.so ../test/jp/co/infoseek/hp/arton/rjb/Test.class ../test/jp/co/infoseek/hp/arton/rjb/IBase.class ../test/jp/co/infoseek/hp/arton/rjb/Base.class ../test/jp/co/infoseek/hp/arton/rjb/ExtBase.class 
	ruby ../test/test.rb
../test/jp/co/infoseek/hp/arton/rjb/Test.class : ../test/Test.java 
	javac ../test/Test.java
	$(RUBY) -r fileutils -e 'FileUtils.mkdir_p "../test/jp/co/infoseek/hp/arton/rjb";FileUtils.mv("../test/Test.class", "../test/jp/co/infoseek/hp/arton/rjb")'
../test/jp/co/infoseek/hp/arton/rjb/IBase.class : ../test/IBase.java 
	javac ../test/IBase.java
	$(RUBY) -r fileutils -e 'FileUtils.mkdir_p "../test/jp/co/infoseek/hp/arton/rjb";FileUtils.mv("../test/IBase.class", "../test/jp/co/infoseek/hp/arton/rjb")'
../test/jp/co/infoseek/hp/arton/rjb/Base.class : ../test/Base.java ../test/jp/co/infoseek/hp/arton/rjb/IBase.class
	javac -classpath ../test ../test/Base.java
	$(RUBY) -r fileutils -e 'FileUtils.mkdir_p "../test/jp/co/infoseek/hp/arton/rjb";FileUtils.mv("../test/Base.class", "../test/jp/co/infoseek/hp/arton/rjb")'
../test/jp/co/infoseek/hp/arton/rjb/ExtBase.class : ../test/ExtBase.java 
	javac -classpath ../test ../test/ExtBase.java
	$(RUBY) -r fileutils -e 'FileUtils.mkdir_p "../test/jp/co/infoseek/hp/arton/rjb";FileUtils.mv("../test/ExtBase.class", "../test/jp/co/infoseek/hp/arton/rjb")'
