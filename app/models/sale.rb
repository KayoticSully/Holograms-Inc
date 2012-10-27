class Sale < ActiveRecord::Base
  attr_accessible :end, :markdown, :name, :start
  
  has_many :products
end
