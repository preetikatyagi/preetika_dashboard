class CreateTreatments < ActiveRecord::Migration
  def self.up
    create_table :treatments do |t|
      t.integer :concept_id, :null => false
      t.integer :drug_id, :null => false
      t.integer :weight, :default => 0
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :treatments
  end
end
