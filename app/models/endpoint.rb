class Endpoint < ActiveRecord::Base
  belongs_to :category
  belongs_to :prediction_type
  belongs_to :database

  after_create :set_port

  def path
    "#{RAILS_ROOT}/public/data/#{rel_path}"
  end

  def data_path
    path + "/data/"
  end

  def validation_path
    path + "/validation/"
  end

  def rel_path
    id
  end

  def uri
    "/" + rel_path
  end

  def structure_file
    path + "/data/" + name + ".smi"
  end

  def activity_file
    case prediction_type.name
    when "classification"
      path + "/data/" + name + ".class"
    when "regression"
      path + "/data/" + name + ".act"
    end
  end

  def feature_file
    path + "/data/" + name + ".linfrag"
  end

  def set_port
    update_attribute(:port, next_port)
  end

  def next_port
    endpoints = Endpoint.find(:all)
    last_port = endpoints.collect{|e| e.port if e.port}.compact.max 
    if last_port.nil?
      10000
    else
      last_port + 1
    end
  end

end
