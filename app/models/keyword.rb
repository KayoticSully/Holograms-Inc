class Keyword < ActiveRecord::Base
  attr_accessible :name, :under, :products
  
  has_many :groups
  has_many :products, :through => :groups
end
