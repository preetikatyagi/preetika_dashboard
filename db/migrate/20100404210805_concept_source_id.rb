class ConceptSourceId < ActiveRecord::Migration
  def self.up
	add_column	:concepts,	:source_id,	:integer, :null => true
  end

  def self.down
	remove_column	:concepts,	:source_id
  end
end
