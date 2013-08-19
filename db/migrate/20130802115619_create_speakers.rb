class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|

      t.references :discussion
      t.references :user

      t.timestamps
    end

    add_index :speakers, :discussion_id
    add_index :speakers, :user_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
