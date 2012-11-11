class Product < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :description, :image, :name, :price, :public, :stock, :weight, :height, :length, :width, :rating, :sale_id
  
  #medium was 240x240 i changed it to 212x212 because it seemed nicer
  has_attached_file :image, :styles => { :medium => ["212x212>", :png], :small => ["50x50>", :png], :large => ["265>x280>", :png] }
  
  has_many :groups
  has_many :keywords, :through => :groups
  belongs_to :sale
  
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :stock, :numericality => { :greater_than_or_equal_to => 0, :only_integer => true }
  validates :weight, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :height, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :length, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :width, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :rating, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5, :only_integer => true }
  
  # Returns the sale price if the item is on sale and false if it is not
  def sale_price
    if (sale)
      price * (100-sale.markdown) / 100
    else
      false
    end
  end
  
  # Returns the markdown of the sale that this product is participating in and false if it's not on sale
  def sale_markdown
    if (sale)
      sale.markdown
    else
      false
    end
  end
end