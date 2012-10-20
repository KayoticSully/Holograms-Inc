class AddQuantityToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :quantity, :integer
  end
end
