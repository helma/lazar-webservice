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

# get and install ruby
git clone http://opentox.org/git/ch/ruby.git vendor/src/ruby
cd vendor/lib/ruby
./configure --prefix=$prefix
make install
cd app_dir
export PATH=$PATH:$app_dir/vendor/bin/
alias ruby=$PATH:$app_dir/vendor/bin/ruby

# get and install rubygems
export GEM_HOME=$prefix/gems
git clone http://opentox.org/git/ch/rubygems.git vendor/src/rubygems
cd vendor/lib/rubygems
ruby setup.rb config --prefix=$prefix
ruby setup.rb setup
ruby setup.rb install
alias gem=$PATH:$app_dir/vendor/bin/gem

# get rake
gem install rake -v "0.8.1"
#rake update
