class RemoveInversibleIdFromFriendships < ActiveRecord::Migration
  def self.up
    remove_column :friendships, :inversible_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
