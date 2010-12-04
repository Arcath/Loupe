class AddMountpointToDisk < ActiveRecord::Migration
  def self.up
    add_column :disks, :mountpoint, :string
  end

  def self.down
    remove_column :disks, :mountpoint
  end
end
