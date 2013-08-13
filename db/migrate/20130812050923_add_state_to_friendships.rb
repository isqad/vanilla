class AddStateToFriendships < ActiveRecord::Migration
  def self.up
    add_column :friendships, :state, :string, :default => 'pending'
    remove_column :friendships, :status

    add_index :friendships, :state
  end

  def self.down
    remove_column :friendships, :state
    add_column :friendships, :status, :integer, :null => false, :default => 0
  end
end
