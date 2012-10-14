class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  
  attr_accessible :total_price, :user_id, :purchased
end
