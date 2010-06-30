class SuggestionGeneratorJob < Struct.new(:analysis_id)

	def perform
		# The Paperclip plugin should be puttin stuff in public/system/datas/<upload_id>/original/<file_name>		
		a = Analysis.find(analysis_id)
		a.generate_suggestions
	end
	
end