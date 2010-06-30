class GeneIds < ActiveRecord::Migration
  
  def self.up
    rename_column :genes, :name, :hugo_id
    add_column  :genes, :entrez_id, :string
  end
  
  def self.down
    rename_column :genes, :hugo_id, :name
    remove_column :genes, :entrez_id
  end
  
end
