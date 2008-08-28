require 'yaml'

namespace :app do

  desc "Install/update git plugins and data"
  task :install do
    sh "git pull"
    YAML::load(File.open("config/plugins.yml")).each do |plugin|
      # update/create plugin
      puts "updating #{plugin['url']}"
      sh "git clone #{plugin['url']} #{plugin['path']}"
      if File.directory?(plugin['path'])
        sh "cd #{plugin['path']} && git pull"
      else
      end
      # get the correct tag
      puts "switching to tag #{plugin['tag']} of  #{plugin['url']}" if plugin['tag']
      sh "cd #{plugin['path']} && git checkout -b #{plugin['tag']} #{plugin['tag']}" if plugin['tag']
      # reread environment to obtain all additional rake tasks
      require "#{RAILS_ROOT}/config/environment.rb"
      # run installation commands
      sh "#{plugin['install']}" if plugin['install']
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

