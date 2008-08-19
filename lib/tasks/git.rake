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
    puts "switching to tag #{plugin['version']} of  #{plugin['url']}" if plugin['version']
    puts `cd #{plugin['path']} && git checkout -b #{plugin['version']} #{plugin['version']}` if plugin['version']
    # run installation commands
    puts `#{plugin['install']}` if plugin['install']
  end
end

desc "Check svn status" 
task :status do
  system "svn status"
  tree = YAML::parse(File.open("config/svn.yml")).transform
  tree.each do |key,data|
    if data
      data.each do |svn_path|
        case key
        when "plugins"
          dir = "vendor/plugins/"+File.basename(svn_path.sub(/trunk/,''))
        when "data"
          dir = "public/data/"+File.basename(svn_path)
        end
        system "svn status #{dir}"
      end
    end
  end
end

