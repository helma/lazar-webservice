class Category < ActiveRecord::Base
  has_many :endpoints

  def to_param
    name
  end

end
