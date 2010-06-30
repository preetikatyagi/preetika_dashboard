class RenameSampleHugoIdToEnsemblId < ActiveRecord::Migration

  def self.up
	rename_column :samples, :hugo_id, :ensembl_id
	add_index :samples, :ensembl_id
  end

  def self.down
	rename_column :samples, :ensembl_id, :hugo_id
	remove_index :samples, :ensembl_id
  end

end
