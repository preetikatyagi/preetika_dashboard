require 'idclight'

class Gene < ActiveRecord::Base

	include IDConverter::Light
	
	has_many	:members, :dependent => :destroy

	validates_presence_of	:hugo_id
	
	def self.attempt_id_conversions
		Gene.all(:conditions => 'hugo_id IS NOT NULL AND (ensembl_id IS NULL OR ensembl_id = "")').each do |g| g.attempt_hugo_to_ensembl_conversion end
		Gene.all(:conditions => 'hugo_id IS NOT NULL AND (entrez_id IS NULL OR entrez_id = "")').each do |g| g.attempt_hugo_to_entrez_conversion end
	end
	
	def attempt_id_conversions(override = false)
		attempt_hugo_to_ensembl_conversion(override)
		attempt_hugo_to_entrez_conversion(override)
	end
	
	def attempt_hugo_to_ensembl_conversion(override = false)
		h = self.hugo_id
		# puts h
		if h && h != '' && (self.ensembl_id.nil? || self.ensembl_id == '' || override)
			ens = hugo_id_to_ensembl_id(h)
			# puts ens
			if ens
				self.ensembl_id = ens
				self.save!
			end
		end
	end
	
	def attempt_hugo_to_entrez_conversion(override = false)
		h = self.hugo_id
		if h && h != '' && (self.entrez_id.nil? || self.entrez_id == '' || override)
			ens = hugo_id_to_entrez_id(h)
			if ens
				self.entrez_id = ens
				self.save!
			end
		end
	end
	
end
