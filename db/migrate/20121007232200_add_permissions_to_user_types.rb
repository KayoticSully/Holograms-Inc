class AddPermissionsToUserTypes < ActiveRecord::Migration
  def change
    add_column :user_types, :purchase, :boolean
    add_column :user_types, :products_edit, :boolean
    add_column :user_types, :products_quantity, :boolean
    add_column :user_types, :help_edit, :boolean
  end
end
