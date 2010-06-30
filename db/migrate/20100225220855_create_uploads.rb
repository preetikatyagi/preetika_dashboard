class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.binary :data, :null => false
	  t.integer :format_id, :null => false
	  t.integer :import_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
