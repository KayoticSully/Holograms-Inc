class AddColumnPasswordSalt < ActiveRecord::Migration
  change_table :Users do |t|
    t.string :password_salt
  end
end
