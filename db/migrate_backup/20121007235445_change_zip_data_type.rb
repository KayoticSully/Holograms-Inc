class ChangeZipDataType < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :zipcode, :string
    end
  end

  def self.down
    change_table :users do |t|
      t.change :zipcode, :integer
    end
  end
end
