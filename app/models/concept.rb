class Concept < ActiveRecord::Base
	
	belongs_to	:orientation
	belongs_to	:aberration
	belongs_to	:phenotype
	belongs_to	:source

	has_many	:members, :dependent => :destroy
	has_many	:treatments, :dependent => :destroy

	validates_presence_of	:name
	validates_presence_of	:orientation
	validates_presence_of	:aberration
	validates_presence_of	:phenotype
	
	# FIXME OH GOD why is this broken???
	# has_and_belongs_to_many	:children,
	# 	:join_table => 'subconcepts',
	# 	:class_name => 'Concept',
	# 	:foreign_key => 'parent_id',
	# 	:association_foreign_key => 'child_id'
	# 
 	# has_and_belongs_to_many	:parents,
 	# 	:join_table => 'subconcepts',
 	# 	:class_name => 'Concept',
 	# 	:foreign_key => 'child_id',
 	# 	:association_foreign_key => 'parent_id'

	
	# FIXME A hack for the above bug: gets the join table records. 
	has_many :parent_subconcepts, :class_name => 'Subconcept', :foreign_key => 'child_id', :dependent => :destroy
	has_many :child_subconcepts, :class_name => 'Subconcept', :foreign_key => 'parent_id', :dependent => :destroy
	
	def to_mindmap_json
		gene_group_id = "GeneNode"
		drug_group_id = "DrugNode"
		
		concept = {:name => name, :id => node_id, :adjacencies => [gene_group_id, drug_group_id]} # children adjacencies
		gene_group = {:name => 'Genes', :id => gene_group_id, :adjacencies => [concept[:id]]}
		drug_group = {:name => 'Drugs', :id => drug_group_id, :adjacencies => [concept[:id]]}
		j = [concept, gene_group, drug_group]

		members.each do |m|
			gene = m.gene
			gene_node = {:name => gene.hugo_id, :id => gene.node_id, :adjacencies => []}
			gene_group[:adjacencies] <<  gene_node[:id]
			j << gene_node
		end
		
		treatments.each do |t|
			drug = t.drug
			drug_node = {:name => drug.name, :id => drug.node_id, :adjacencies => []}
			drug_group[:adjacencies] <<  drug_node[:id]
			j << drug_node
		end

		j
	end


end
