class AddConceptRelations < ActiveRecord::Migration
	
  def self.up
	add_column	:concepts,	:aberration_id,		:integer,	:null => false,	:default => 0
	add_column	:concepts,	:orientation_id,	:integer,	:null => false,	:default => 0
	add_column	:concepts,	:phenotype_id,		:integer,	:null => false,	:default => 0
  end

  def self.down
	remove_column	:concepts,	:aberration_id
	remove_column	:concepts,	:orientation_id
	remove_column	:concepts,	:phenotype_id
  end

end
