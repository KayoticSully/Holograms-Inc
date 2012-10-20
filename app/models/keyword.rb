class Keyword < ActiveRecord::Base
  attr_accessible :name, :under, :products
  
  has_many :groups
  has_many :products, :through => :groups
  
  def inspect
    name
  end
  
  def to_param
    return name.gsub(/\s+/, '_').downcase
  end
end
