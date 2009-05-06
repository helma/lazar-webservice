require 'socket'                # Get sockets from stdlib
require "lib/lazar/lazar"
class Server

  def initialize(model)
    Dir.chdir("#{RAILS_ROOT}/lib/lazar") #necessary for unknown reasons
    server = TCPServer.open(model.port)   # Socket to listen on port
    if model.regression
      Lazar.kernel = true
      Lazar.quantitative = true
      Lazar.sig_thr = 0.95
      predictor =  Lazar::RegressionPredictor.new(model.structure_file, model.activity_file, model.feature_file, "data/elements.txt", Lazar::getStringOut)
    else
      predictor =  Lazar::ClassificationPredictor.new(model.structure_file, model.activity_file, model.feature_file, "data/elements.txt", Lazar::getStringOut)
    end
    loop {                          # Servers run forever
      Thread.start(server.accept) do |client|
        smiles = client.readline.chomp
        predictor.predict_smi(smiles)
        client.puts(predictor.get_yaml)
        puts(predictor.get_yaml)
        client.close
      end
    }
  end

end
