class RemoveUnnecessaryFieldsFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :unconfirmed_email
    remove_column :users, :confirmation_sent_at
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_token
    remove_column :users, :last_sign_in_ip
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_at
    remove_column :users, :sign_in_count
    remove_column :users, :remember_created_at
    remove_column :users, :reset_password_sent_at
    remove_column :users, :reset_password_token
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
