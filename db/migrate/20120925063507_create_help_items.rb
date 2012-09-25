class CreateHelpItems < ActiveRecord::Migration
  def change
    create_table :help_items do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
