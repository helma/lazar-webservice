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

  def validation_file
    data_path + name + ".loo"
  end

  def validation_loo_filename
    name + ".loo"
  end

  def validation_summary_file
    data_path + name + ".summary"
  end

  def validation_summary_filename
    name + ".summary"
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
