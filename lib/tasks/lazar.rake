require 'digest/md5'
namespace :lazar do

  desc "Install lazar-core and prepare the lazar webservice"
  task :setup => [:install, "db:migrate", :create_user] do
  end

  task :install do
    `git clone git@github.com:helma/lazar-core.git lib/lazar-core`
    Dir.chdir("#{RAILS_ROOT}/lib/lazar-core")
    `git checkout -b nosocket origin/nosocket`
    `make lazar.so linfrag`
  end

  desc "Create a new user"
  task :create_user do
    print "Username (for model creation): "
    username = STDIN.gets.chomp
    print "Password: "
    password = STDIN.gets.chomp
    User.create(:name => username, :hashed_password => Digest::MD5.hexdigest(password))
  end

end
