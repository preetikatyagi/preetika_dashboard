class UploadProcessorJob < Struct.new(:upload_id)

	def perform
		# The Paperclip plugin should be puttin stuff in public/system/datas/<upload_id>/original/<file_name>
		
		u = Upload.find(upload_id)
		p = UploadProcessor.new
		file_name = File.expand_path("../../public/system/datas/#{u.id}/original/#{u.data_file_name}",  __FILE__)
		puts "Processing starting for upload ##{u.id}. (This will take a while.)"
		r = p.process_upload(u, file_name)
		puts "Processing of upload ##{u.id} complete! Statistics:"
		puts "\tSamples:\t #{r[:samples]}"
		puts "\tTotal Time:\t#{r[:total_time]} seconds"
		puts "\tRate:\t#{r[:rate]} samples/second"
	end
	
end