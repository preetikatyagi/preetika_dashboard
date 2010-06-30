class CreateAberrations < ActiveRecord::Migration
  def self.up
    create_table :aberrations do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :aberrations
  end
end
