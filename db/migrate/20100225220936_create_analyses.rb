class CreateAnalyses < ActiveRecord::Migration
  def self.up
    create_table :analyses do |t|
      t.integer :analyst_id, :null => false
      t.integer :import_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :analyses
  end
end
