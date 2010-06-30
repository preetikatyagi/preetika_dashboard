class AddDrugDetails < ActiveRecord::Migration

  def self.up
	add_column	:sources, :code, :string
	
	add_column	:drugs, :description, :string
	add_column	:drugs, :external_id, :string
	add_column	:drugs, :brand_names, :string
	add_column	:drugs, :generic_names, :string
	add_column	:drugs, :biotransformation, :string
	add_column	:drugs, :chemical_formula, :string
	add_column	:drugs, :absorption, :string
	add_column	:drugs, :drug_interactions, :string
	add_column	:drugs, :half_life, :string
	add_column	:drugs, :kegg_drug_id, :string
	add_column	:drugs, :lims_drug_id, :string
	add_column	:drugs, :pubchem_compound_id, :string
	add_column	:drugs, :pubchem_substance_id, :string
	add_column	:drugs, :genbank_id, :string
	add_column	:drugs, :dpd_drug_id, :string
	add_column	:drugs, :drug_type, :string
  end

  def self.down
	remove_column	:sources, :code

	remove_column	:drugs, :description
	remove_column	:drugs, :external_id
	remove_column	:drugs, :brand_names
	remove_column	:drugs, :generic_names
	remove_column	:drugs, :biotransformation
	remove_column	:drugs, :chemical_formula
	remove_column	:drugs, :absorption
	remove_column	:drugs, :drug_interactions
	remove_column	:drugs, :half_life
	remove_column	:drugs, :kegg_drug_id
	remove_column	:drugs, :lims_drug_id
	remove_column	:drugs, :pubchem_compound_id
	remove_column	:drugs, :pubchem_substance_id
	remove_column	:drugs, :genbank_id
	remove_column	:drugs, :dpd_drug_id
	remove_column	:drugs, :drug_type
  end

end
