class RenameProductKeywordsToGroupings < ActiveRecord::Migration
  def change
    rename_table :product_keywords, :groups
  end
end
