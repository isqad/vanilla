class AddLasResponseAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_response_at, :datetime, :default => nil
  end
end
