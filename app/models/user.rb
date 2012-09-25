class User < ActiveRecord::Base
  belongs_to :user_type
  has_many :orders
  
  attr_accessible :address, :city, :credit_card, :email_address, :first_name, :hashed_password, :last_name, :phone_number, :user_type_id, :zipcode
end
