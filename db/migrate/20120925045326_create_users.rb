class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zipcode
      t.string :email_address
      t.string :hashed_password
      t.string :credit_card
      t.string :phone_number
      t.integer :user_type_id

      t.timestamps
    end
  end
end
