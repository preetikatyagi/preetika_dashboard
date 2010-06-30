class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :gene_id, :null => false
      t.integer :concept_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
