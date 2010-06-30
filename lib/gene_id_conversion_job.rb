class GeneIdConversionJob < Struct.new(:gene_id)

	def perform
		if gene_id.nil?
			Gene.attempt_id_conversions
		else
			g = Gene.find(gene_id)
			g.attempt_id_conversions
		end
	end
	
end