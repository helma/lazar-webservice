class Model < ActiveRecord::Base

  belongs_to :user
  has_one :server

  def data_path
    "#{RAILS_ROOT}/public/models#{uri}/"
  end

  def uri
    "/" + id.to_s
  end

  def structure_file
    data_path + name + ".smi"
  end

  def activity_file
    if regression
      data_path + name + ".act"
    else
      data_path + name + ".class"
    end
  end

  def feature_file
    data_path + name + ".linfrag"
  end

  def port
    20000 + id
  end

  def server?
    if TCPSocket.new('localhost', self.port) 
      true
    else
      false
    end
  end

end
