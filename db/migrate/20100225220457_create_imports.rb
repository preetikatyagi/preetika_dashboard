class CreateImports < ActiveRecord::Migration
  def self.up
    create_table :imports do |t|
      t.blob :data
      t.format :format_id
      t.integer :importer_id, :null => false
      t.integer :patient_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :imports
  end
end
