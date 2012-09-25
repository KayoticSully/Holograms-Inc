class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.boolean :products

      t.timestamps
    end
  end
end
