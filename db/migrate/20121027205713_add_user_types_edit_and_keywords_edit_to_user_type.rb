class AddUserTypesEditAndKeywordsEditToUserType < ActiveRecord::Migration
  def change
    add_column :user_types, :user_types_edit, :boolean
    add_column :user_types, :keywords_edit, :boolean
  end
end
