class ConceptPubmedIdAndNotes < ActiveRecord::Migration
	
  def self.up
	add_column	:concepts,	:pubmed_id,	:integer,	:null => true
	add_column	:concepts,	:notes,	:string,	:null => true
  end

  def self.down
	remove_column	:concepts,	:pubmed_id
	remove_column	:concepts,	:notes
  end

end
