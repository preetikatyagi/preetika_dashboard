class Sample < ActiveRecord::Base
	
	belongs_to	:upload
	belongs_to	:chromosome
	belongs_to	:sample_type
	belongs_to	:zygosity
	belongs_to	:gene
	
	validates_presence_of	:upload
	validates_presence_of	:chromosome
	validates_presence_of	:sample_type
	validates_presence_of	:zygosity
	# validates_presence_of	:gene_id # This might be populated after the import for performance reasons.
	
end
