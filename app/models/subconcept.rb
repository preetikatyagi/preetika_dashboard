class Subconcept < ActiveRecord::Base

	belongs_to :parent, :class_name => 'Concept', :foreign_key => 'parent_id'
	belongs_to :child, :class_name => 'Concept', :foreign_key => 'child_id'

	validates_presence_of	:parent
	validates_presence_of	:child
	
	validates_uniqueness_of	:parent_id, :scope => [:child_id], :message => 'duplicate relationship detected.'
	
	validate :cannot_reference_self

  def cannot_reference_self
    errors.add_to_base('You cannot define a concept as a subconcept of itself. :)') if self.parent_id == self.child_id
  end
  
	
end
