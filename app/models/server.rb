require 'socket'                # Get sockets from stdlib
class Server

  def initialize(endpoint)
    Dir.chdir("#{RAILS_ROOT}/lib/lazar") #necessary for unknown reasons
    server = TCPServer.open(endpoint.port)   # Socket to listen on port
    case endpoint.prediction_type.name
    when "classification"
      predictor =  Lazar::ClassificationPredictor.new(endpoint.structure_file, endpoint.activity_file, endpoint.feature_file, "data/elements.txt", Lazar::getStringOut)
    when "regression"
      Lazar.kernel = true
      Lazar.quantitative = true
      Lazar.sig_thr = 0.95
      predictor =  Lazar::RegressionPredictor.new(endpoint.structure_file, endpoint.activity_file, endpoint.feature_file, "data/elements.txt", Lazar::getStringOut)
    else
      exit
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
