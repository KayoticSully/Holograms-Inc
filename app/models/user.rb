class User < ActiveRecord::Base
  attr_accessible :address, :city, :credit_card, :email_address, :first_name, :hashed_password, :last_name, :phone_number, :user_type_id, :zipcode
end
