class AddTimestampsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :created_at, :datetime, :null => false
    add_column :photos, :updated_at, :datetime, :null => false
  end
end
