class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
