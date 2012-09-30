class CreateProductKeywords < ActiveRecord::Migration
  def change
    create_table :product_keywords do |t|
      t.integer :product_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end
