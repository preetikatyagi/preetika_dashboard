class AddDrugNameIndexes < ActiveRecord::Migration
	
  def self.up
	add_index	:drugs, :brand_names
	add_index	:drugs, :generic_names
  end

  def self.down
	remove_index	:drugs, :brand_names
	remove_index	:drugs, :generic_names
  end

end
