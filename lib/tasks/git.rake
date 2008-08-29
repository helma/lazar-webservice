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
      if File.directory?(plugin['path'])
        sh "cd #{plugin['path']} && git pull"
      else
        sh "git clone #{plugin['url']} #{plugin['path']}"
      end
      # get the correct tag
      #puts "switching to tag #{plugin['tag']} of  #{plugin['url']}" if plugin['tag']
      #sh "cd #{plugin['path']} && git checkout #{plugin['tag']} #{plugin['tag']}" if plugin['tag']
      # reread environment to obtain all additional rake tasks
      #require "#{RAILS_ROOT}/config/environment.rb"
      # run installation commands
      #sh "#{plugin['install']}" if plugin['install']
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

