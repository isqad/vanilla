class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.attachment :image
      t.text :image_meta
      t.references :user
    end

    add_index :photos, :user_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
