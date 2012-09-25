class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :image
      t.integer :stock
      t.boolean :public

      t.timestamps
    end
  end
end
