class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price, :public, :stock, :weight, :height, :length, :width, :rating, :sale_id
  
  #medium was 240x240 i changed it to 212x212 because it seemed nicer
  has_attached_file :image, :styles => { :medium => ["212x212>", :png], :small => ["50x50>", :png], :large => ["265>x280>", :png] }
  
  has_many :groups
  has_many :keywords, :through => :groups
  belongs_to :sale
end