class AddNameToUserTypes < ActiveRecord::Migration
  def change
    add_column :user_types, :name, :string
  end
end
