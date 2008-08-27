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

app_dir=`pwd`
prefix=$app_dir/vendor
bin_dir=$prefix/bin
src_dir=$prefix/src

export PATH=$PATH:$bin_dir

# get and install ruby
src=$src_dir/ruby
git clone http://opentox.org/git/ch/ruby.git $src
cd $src
./configure --prefix=$prefix
make
make install
cd $app_dir

alias ruby=$app_dir/vendor/bin/ruby

# get and install rubygems
src=$src_dir/rubygems
export GEM_HOME=$prefix
git clone http://opentox.org/git/ch/rubygems.git $src
cd $src
$bin_dir/ruby setup.rb config --prefix=$prefix
$bin_dir/ruby setup.rb setup
$bin_dir/ruby setup.rb install
cd $app_dir

alias gem=$app_dir/vendor/bin/gem

# get and install rake
$bin_dir/gem install rake -v "0.8.1"
export PATH=$PATH:$app_dir/vendor/gems/bin/
alias rake=$app_dir/vendor/gems/bin/rake

# get and install openbabel
src=$src_dir/openbabel
git clone http://opentox.org/git/ch/openbabel.git $src
cd $src
./configure --prefix=$prefix
make
make install
cd $src/scripts/ruby
ruby extconf.rb --with-openbabel-dir=$prefix
make
export DESTDIR=$prefix
make install
cd $app_dir

# get and install R
src=$src_dir/R
git clone http://opentox.org/git/ch/R.git $src
cd $src
./configure --prefix=$prefix
make
make install
export R_HOME=$prefix/
# kernlab should be installed by lazar
    #sh "export R_HOME=#{path}/lib/R && cd #{src} &&  #{path}/bin/R CMD INSTALL kernlab_0.9-7.tar.gz"
cd $app_dir

#rake update
