class AddShippingCostAndMethodToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_cost, :float
    add_column :orders, :shipping_method, :string
  end
end
