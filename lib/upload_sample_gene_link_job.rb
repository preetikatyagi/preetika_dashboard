class UploadSampleGeneLinkJob < Struct.new(:upload_id)

	def perform
		u = Upload.find(upload_id)
		u.link_samples_to_genes
	end
	
end