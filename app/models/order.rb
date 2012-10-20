class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  
  attr_accessible :total_price, :user_id, :purchased
  
  def size
    size = 0
    
    order_items.each do |order_item|
      size += order_item.quantity
    end
    
    size
  end
end
