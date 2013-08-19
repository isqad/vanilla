class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :body
      t.references :discussion
      t.references :user

      t.timestamps
    end

    add_index :messages, :discussion_id
    add_index :messages, :user_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
