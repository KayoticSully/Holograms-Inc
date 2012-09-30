class RenameUserHashedPasswordToPasswordDigest < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :hashed_password, :password_digest
  end
end
