class UserType < ActiveRecord::Base
  has_many :users
  attr_accessible :products
end
