class CreateZygosities < ActiveRecord::Migration
  def self.up
    create_table :zygosities do |t|
      t.string :import_code,	:null => false, :limit => 16
      t.timestamps
    end
  end

  def self.down
    drop_table :zygosities
  end
end
