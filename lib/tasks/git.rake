require 'yaml'

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

  desc "Commit changes in all modified git repositories" 
  task :commit do
    if message = ENV['m']
      sh "git commit -am '#{message}'"
      YAML::load(File.open("config/plugins.yml")).each do |plugin|
        sh "cd #{plugin['path']} && git commit -am '#{message}'"
      end
    else
      puts "Please enter a message with rake:commit m=\"my message\""
    end

  end
end

