class AddDefaultToProductsForRatings < ActiveRecord::Migration
  def up
    change_column :products, :rating, :integer, :default => 0
  end
  
  def down
  end
end
