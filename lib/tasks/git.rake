require 'yaml'

namespace :app do

  plugins = YAML::load(File.open("config/plugins.yml"))

  desc "Install/update git plugins and data"
  task :install => :update do
    plugins.each do |plugin|
      puts "installing #{plugin['url']}"
      puts  plugin['install'] if plugin['install']
      sh "#{plugin['install']}" if plugin['install']
    end
  end

  task :update do
    sh "git pull"
    plugins.each do |plugin|
      # update/create plugin
      puts "updating #{plugin['url']}"
      sh "git clone #{plugin['url']} #{plugin['path']}" unless File.directory?(plugin['path'])
      sh "cd #{plugin['path']} && git pull"
      # get the correct tag
      #sh "cd #{plugin['path']} && git checkout -b #{plugin['tag']} " if plugin['tag']
    end
  end

end

namespace :git do

  desc "Check git status" 
  task :status do
    puts RAILS_ROOT
    begin
      sh "git status"
    rescue
    end
    YAML::load(File.open("config/plugins.yml")).each do |plugin|
      puts "#{RAILS_ROOT}/#{plugin['path']}"
      begin
        sh "cd #{plugin['path']} && git status"
      rescue
      end
    end
  end

end

