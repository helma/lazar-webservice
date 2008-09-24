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
      begin
        sh "git commit -am '#{message}'"
      rescue
      end
      YAML::load(File.open("config/plugins.yml")).each do |plugin|
        begin
          sh "cd #{plugin['path']} && git commit -am '#{message}'"
        rescue
        end
      end
    else
      puts "Please enter a message with rake:commit m=\"my message\""
    end
  end

  desc "Switch to development mode"
  task :development do
    if push = ENV['push']
      if `grep push .git/config`.chomp.size == 0
        push_url = push+'/'+File.basename(`grep url .git/config`.sub(/\s+url =\s+/,''))
        sh "git config remote.origin.push #{push_url}" 
        sh "cd .git/hooks/ && echo 'git push' > post-commit && chmod u+x post-commit"
      end
      YAML::load(File.open("config/plugins.yml")).each do |plugin|
        push_url = push+"/"+File.basename(plugin['url'])
        puts push_url
        sh "cd #{plugin['path']} && git config remote.origin.push #{push_url}" 
        sh "cd #{plugin['path']}/.git/hooks/ && echo 'git push' > post-commit && chmod u+x post-commit"
      end
    else
      puts "Please provide the basename for a git repository with rake:development push=\"my git repository\""
    end
  end

end

