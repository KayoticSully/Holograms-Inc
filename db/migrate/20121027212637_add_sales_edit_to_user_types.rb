class AddSalesEditToUserTypes < ActiveRecord::Migration
  def change
    add_column :user_types, :sales_edit, :boolean, :null => false
  end
end
