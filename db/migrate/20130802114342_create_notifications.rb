class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.text :notify, :null => false
      t.references :user
      t.integer :from_id

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, :from_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
