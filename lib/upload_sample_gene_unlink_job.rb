class UploadSampleGeneUnlinkJob < Struct.new(:upload_id)

	def perform
		u = Upload.find(upload_id)
		u.unlink_samples_to_genes
	end
	
end