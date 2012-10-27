class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.float :markdown
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
