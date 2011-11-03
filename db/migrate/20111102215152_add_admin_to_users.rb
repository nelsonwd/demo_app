class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :enabled, :boolean, :default => false
  end

  def self.down
    remove_column :users, :enabled
    remove_column :users, :admin
  end
end
