class RemoveFromProductAddToUser < ActiveRecord::Migration
  def up
    remove_column :products, :state
    remove_column :products, :country
    add_column :users, :state, :string
    add_column :users, :country, :string
  end

  def down
    add_column :products, :state, :string
    add_column :products, :country, :string
    remove_column :users, :state
    remove_column :users, :country
  end
end
