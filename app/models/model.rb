class Model < ActiveRecord::Base

  def data_path
    "#{RAILS_ROOT}/public/data#{uri}/"
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
    10000 + id
  end

end
