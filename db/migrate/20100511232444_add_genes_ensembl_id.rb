class AddGenesEnsemblId < ActiveRecord::Migration

  def self.up
	add_column	:genes, :ensembl_id, :string, :limit => 32
	add_index	:genes, :ensembl_id
  end

  def self.down
	remove_index	:genes, :ensembl_id
	remove_column	:genes, :ensembl_id
  end

end
