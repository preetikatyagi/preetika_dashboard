class RemoveUploadDataField < ActiveRecord::Migration
  def self.up
	remove_column :uploads, :data
	remove_column :uploads, :format_id
  end

  def self.down
	add_column :uploads, :data, :binary, :null => false, :default => ''
	add_column :uploads, :format_id, :integer
  end
end
