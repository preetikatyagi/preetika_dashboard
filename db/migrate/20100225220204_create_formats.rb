class CreateFormats < ActiveRecord::Migration
  def self.up
    create_table :formats do |t|
      t.string :name
      t.string :mime_type
      t.string :file_suffix

      t.timestamps
    end
  end

  def self.down
    drop_table :formats
  end
end
