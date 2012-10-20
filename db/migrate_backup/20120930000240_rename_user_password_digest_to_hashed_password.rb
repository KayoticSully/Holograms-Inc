class RenameUserPasswordDigestToHashedPassword < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :password_digest, :hashed_password
  end
end
