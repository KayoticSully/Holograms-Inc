class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :product_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end
