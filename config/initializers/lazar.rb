# start lazar servers
require "#{RAILS_ROOT}/lib/lazar/lazar"
require 'lib/daemon_controller/lib/daemon_controller'
ENV['R_HOME'] = "/usr/local/lib/R"
Endpoint.find(:all).each do |endpoint|
  #unless endpoint.name.match(/lc50/)
  if endpoint.name == "lc50_mmol"
  puts "Starting #{endpoint.name} daemon."
  pid = fork { Server.new(endpoint) }
  Process.detach(pid)
  end
#  DaemonController.new(
#    :identifier => endpoint.name,
#    :start_command => Server.new(endpoint.path,endpoint.port,endpoint.prediction_type.name),
#    :ping_command => lambda { TCPSocket.new('localhost', endpoint.port) },
#    :pid_file => "tmp/pids/#{endpoint.name}.pid",
#    :log_file => "log/#{endpoint.name}.log"
#  )
end
