class Order < ActiveRecord::Base
  has_many :order_items
  
  attr_accessible :total_price, :user_id
end
