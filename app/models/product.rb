class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price, :public, :stock, :weight, :height, :length, :width
  
  has_many :groups
  has_many :keywords, :through => :groups
end