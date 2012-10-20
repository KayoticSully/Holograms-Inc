class SetDefaultForPurchasedInOrder < ActiveRecord::Migration
  def up
    change_column :orders, :purchased, :default => false
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
