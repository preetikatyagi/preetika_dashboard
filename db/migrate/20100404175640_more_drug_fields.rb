class MoreDrugFields < ActiveRecord::Migration
	
  def self.up
	add_column :drugs, :primary_accession_number, :string # DrugBank DrugCard Primary_Accession_No
	add_column :drugs, :secondary_accession_number, :string # Primary_Accession_No
	add_column :drugs, :chemical_iupac_name, :string # Chemical_IUPAC_Name
	add_column :drugs, :cas_registry_number, :string # CAS_Registry_Number
	add_column :drugs, :kegg_compound_id, :string # KEGG_Compound_ID
	add_column :drugs, :chebi_id, :string # ChEBI_ID
	add_column :drugs, :rxlist_link, :string # RxList_Link
	add_column :drugs, :pharm_gkb_id, :string # PharmGKB_ID
	add_column :drugs, :pdrhealth_link, :string #
	add_column :drugs, :wikipedia_link, :string #
	add_column :drugs, :drug_category, :string # Drug_Category
	add_column :drugs, :pharmacology, :string # Pharmacology
	add_column :drugs, :mechanism_of_action, :string # Mechanism_Of_Action
	add_column :drugs, :indication, :string # Indication
	
	remove_column :drugs, :half_life
	remove_column :drugs, :biotransformation
  end

  def self.down
	remove_column :drugs, :primary_accession_number
	remove_column :drugs, :secondary_accession_number
	remove_column :drugs, :chemical_iupac_name
	remove_column :drugs, :cas_registry_number
	remove_column :drugs, :kegg_compound_id
	remove_column :drugs, :chebi_id
	remove_column :drugs, :rxlist_link
	remove_column :drugs, :pharm_gkb_id
	remove_column :drugs, :pdrhealth_link
	remove_column :drugs, :wikipedia_link
	remove_column :drugs, :drug_category
	remove_column :drugs, :pharmacology
	remove_column :drugs, :mechanism_of_action
	remove_column :drugs, :indication
	
	add_column :drugs, :half_life, :string
	add_column :drugs, :biotransformation, :string
  end

end
