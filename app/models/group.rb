class Group < ActiveRecord::Base
  attr_accessible :keyword_id, :product_id
  
  belongs_to :product
  belongs_to :keyword
end
