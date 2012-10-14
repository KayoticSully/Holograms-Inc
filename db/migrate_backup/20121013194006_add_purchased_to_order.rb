class AddPurchasedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :purchased, :boolean
  end
end
