class AddStateAndCountryToProduct < ActiveRecord::Migration
  def change
    add_column :products, :state, :string
    add_column :products, :country, :string
  end
end
