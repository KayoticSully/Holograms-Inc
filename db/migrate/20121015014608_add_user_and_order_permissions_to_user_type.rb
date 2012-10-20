class AddUserAndOrderPermissionsToUserType < ActiveRecord::Migration
  def change
    add_column :user_types, :users_list, :boolean
    add_column :user_types, :orders_list, :boolean
  end
end
