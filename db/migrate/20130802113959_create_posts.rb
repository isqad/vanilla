class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :body
      t.integer :author_id
      t.timestamps
    end
    add_index :posts, :author_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
