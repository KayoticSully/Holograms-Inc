class RemoveImageFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :image
  end

  def down
    add_column :products, :image, :string
  end
end
