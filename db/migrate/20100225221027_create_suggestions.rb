class CreateSuggestions < ActiveRecord::Migration
  def self.up
    create_table :suggestions do |t|
      t.integer :analysis_id, :null => false
      t.integer :treatment_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :suggestions
  end
end
