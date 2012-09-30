class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price, :public, :stock
  
  has_many :groups
  has_many :keywords, :through => :groups
end
