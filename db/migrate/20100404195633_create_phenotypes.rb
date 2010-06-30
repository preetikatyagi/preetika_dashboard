class CreatePhenotypes < ActiveRecord::Migration
  def self.up
    create_table :phenotypes do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :phenotypes
  end
end
