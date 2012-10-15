class UserType < ActiveRecord::Base
  has_many :users
  
  attr_accessible :products, :purchase, :products_edit, :products_quantity, :help_edit, :name, :users_list, :orders_list
end
