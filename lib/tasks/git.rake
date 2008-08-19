require 'yaml'

desc "Update (or checkout) git plugins and data"
task :update do
  puts `git pull`
  YAML::load(File.open("config/plugins.yml")).each do |plugin|
    # update/create plugin
    puts "updating #{plugin['url']}"
    if File.directory?(plugin['path'])
      puts `cd #{plugin['path']} && git pull`
    else
      puts `git clone #{plugin['url']} #{plugin['path']}`
    end
    # get the correct tag
    puts "switching to tag #{plugin['tag']} of  #{plugin['url']}" if plugin['tag']
    puts `cd #{plugin['path']} && git checkout -b #{plugin['tag']} #{plugin['tag']}` if plugin['tag']
    # run installation commands
    puts `#{plugin['install']}` if plugin['install']
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

