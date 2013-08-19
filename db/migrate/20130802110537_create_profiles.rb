class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name, :default => '', :null => false
      t.string :last_name, :default => '', :null => false
      t.references :user
      t.date :birthday
      t.string :gender, :default => 'male', :null => false
      t.references :photo
      t.text :bio, :null => false, :default => ''
    end

    add_index :profiles, :user_id
    add_index :profiles, :photo_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
