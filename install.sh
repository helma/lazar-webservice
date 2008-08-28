#!/bin/bash
#===============================================================================
#
#          FILE:  install.sh
# 
#         USAGE:  ./install.sh 
# 
#   DESCRIPTION:  installs/updates an OpenTox application
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  helma@in-silico.de, 
#       COMPANY: in silico toxicology 
#       VERSION:  1.0
#       CREATED:  08/27/2008 10:25:01 AM CEST
#      REVISION:  ---
#===============================================================================

: <<'END'

# guess distribution and install dependencies

if grep -q Debian /etc/issue
then
	sudo apt-get install sqlite3 libsqlite3-dev build-essential git-core wget java-jdk 
	sudo apt-get build-dep r-base
	sudo apt-get build-dep openbabel
elif grep -q Ubuntu /etc/issue
then
	sudo apt-get install sqlite3 libsqlite3-dev build-essential git-core wget sun-java6-jdk
	sudo apt-get build-dep r-base
	sudo apt-get build-dep openbabel
else
	dist=`cat /etc/issue|sed 's/\\n \\l//'`
	echo "Installation of dependency packages for $dist not (yet) implemented. Please install sqlite3 (with development libraries), git, java, gcc and fortran compiler with your package manager."
fi
END

git_url=http://opentox.org/git/ch
#git_option=" --depth 1"
git_option=""

app_dir=`pwd`
prefix=$app_dir/vendor
bin_dir=$prefix/bin
src_dir=$prefix/src
plugin_dir=$prefix/plugins

export PATH=$PATH:$bin_dir

# install ruby
src=$src_dir/ruby
# git clone $git_option $git_url/ruby.git $src
# cd $src
# ./configure --prefix=$prefix
# make
# make install
# cd $app_dir

ruby=$app_dir/vendor/bin/ruby
alias ruby=$ruby

# install rubygems
src=$src_dir/rubygems
export GEM_HOME=$prefix
# git clone $git_option $git_url/rubygems.git $src
# cd $src
# $ruby setup.rb config --prefix=$prefix
# $ruby setup.rb setup
# $ruby setup.rb install
# cd $app_dir

gem=$app_dir/vendor/bin/gem
alias gem=$gem

: <<'END'
# install openbabel
src=$src_dir/openbabel
git clone $git_option $git_url/openbabel.git $src
cd $src
./configure --prefix=$prefix
make
make install
cd $src/scripts/ruby
ruby extconf.rb --with-openbabel-dir=$prefix
# fix location of ruby libraries
sed -i 's/topdir = \/usr\/local\//topdir = /' Makefile
make
export DESTDIR=$prefix
make install
topdir=`grep 'topdir =' Makefile|sed 's/topdir = //'`
export RUBYLIB=$prefix/$topdir
cd $app_dir
END

# install R
src=$src_dir/R
r_home=$prefix/lib/R
r_program=$bin_dir/R
export R_HOME=$r_home

: <<'END'
git clone $git_option $git_url/R.git $src
cd $src
./configure --prefix=$prefix --enable-R-shlib
make
make install

# install kernlab
src=$src_dir
mkdir $src
cd $src
wget http://cran.r-project.org/src/contrib/kernlab_0.9-7.tar.gz
$r_program CMD INSTALL kernlab_0.9-7.tar.gz
cd $app_dir

# install gems
# rake
$bin_dir/gem install rake -v "0.8.1"
rake=$app_dir/vendor/gems/bin/rake
alias rake=$rake

$gem install sqlite3-ruby -v "1.2.2" 
$gem install statarray -v "0.0.1"
$gem install haml -v "2.1.0"
$gem install thin -v "0.8.2"
END
export PATH=$PATH:$app_dir/vendor/gems/bin/

if [ ! $JAVA_HOME ]
then
	#export JAVA_HOME=`find /usr -name "jvm"` | sed -n '1p'`
	export JAVA_HOME=`locate -r ".*jvm/.*/bin/java$"|sed 's/\/bin\/java//'`
fi

if [ ! $JAVA_HOME ]
then
	echo "Could not find a home directory of your Java installation. Please install Java and set the $JAVA_HOME variable."
	exit
fi

#$gem install rjb -v "1.1.6" 
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$R_HOME/bin
#$gem install rsruby -v "0.5"  -- --with-R-dir=$R_HOME

# rails
git clone $git_option $git_url/rails.git vendor/rails

# external plugins
cd $plugin_dir
git clone $git_option $git_url/engines.git 
git clone $git_option $git_url/active_scaffold.git
git clone $git_option $git_url/file_column.git
git clone $git_option $git_url/exception_notification.git
cd $app_dir

# create haml plugin
haml --rails .


#rake update
