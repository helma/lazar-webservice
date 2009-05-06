require 'socket'      # Sockets are in standard library

class Client

  def initialize(model,smiles)
    socket = TCPSocket.open("localhost",model.port)
    socket.puts smiles
    result = socket.read
    puts result
    @prediction = YAML::load(result)#.to_yaml
    self.to_xml
  end

  def to_xml

    activating_features = []
    deactivating_features = []
    unknown_features = []

    if @prediction['features']
      @prediction['features'].each do |f|
        case f['property']
        when 'activating'
        activating_features << { :smarts => f['smarts'], :p => f['p_chisq'] }
        when 'deactivating'
        deactivating_features << { :smarts => f['smarts'], :p => f['p_chisq'] }
        end
      end
    end

    if @prediction['unknown_features']
      @prediction['unknown_features'].each do |f|
        unknown_features << { :smarts => f }
      end
    end

    xml = Builder::XmlMarkup.new
    xml.lazar do
      xml.smiles @prediction['smiles']
      xml.inchi @prediction['inchi']
      xml.endpoint @prediction['endpoint']
      xml.prediction @prediction['prediction']
      xml.confidence @prediction['confidence']
      xml.known_fraction @prediction['known_fraction']
      xml.database_activity @prediction['db_activity']
      xml.neighbors do 
        if @prediction['neighbors']
          @prediction['neighbors'].sort{|a,b| b['similarity'] <=> a['similarity']}.each do |n|
            xml.neighbor do
              xml.similarity n['similarity']
              xml.id n['id']
              xml.smiles n['smiles']
              xml.inchi n['inchi']
              xml.activity n['activity']
            end
          end
        end
      end
      xml.features do
        xml.activating do
          activating_features.sort{|a,b| b[:p] <=> a[:p]}.each do |f|
            xml.feature do
              xml.smarts f[:smarts]
              xml.probability f[:p]
            end
          end
        end
        xml.deactivating do
          deactivating_features.sort{|a,b| b[:p] <=> a[:p]}.each do |f|
            xml.feature do
              xml.smarts f[:smarts]
              xml.probability f[:p]
            end
          end
        end
        xml.unknown do
          unknown_features.each do |f|
            xml.feature do
              xml.smarts f[:smarts]
            end
          end
        end
      end
    end

  end
end
