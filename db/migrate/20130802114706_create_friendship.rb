class CreateFriendship < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :owner_id, :null => false
      t.integer :friend_id, :null => false
      t.integer :status, :null => false, :default => 0
      t.integer :inversible_id, :null => false

      t.timestamps
    end

    add_index :friendships, :owner_id
    add_index :friendships, :friend_id
    add_index :friendships, :inversible_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
