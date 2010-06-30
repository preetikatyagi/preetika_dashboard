

namespace :data do
	
	namespace :curate do
		
		desc 'Permanently deletes all import packages, file uploads, sample records, analyses, and anything else dependent on sequence data. BE EXTREMELY CAREFUL!!!'
		task :delete_uploads => :environment do
			# This could take an extremely long time, so we need to be very strategic about the order in which we delete data.
 			# First, the big stuff that doesn't depend on anything can use raw SQL for maximum performance...
			Sample.connection.execute('DELETE FROM samples')
			
			# Now let Rails handle cascading deletes of everything else.
			Upload.destroy_all
			Import.destroy_all
		end
		
		desc 'Permanently deletes all drugs and dependent objects.'
		task :delete_drugs => :environment do
			Drug.destroy_all
		end
		
		desc 'Permanently deletes all import packages, file uploads, sample records, analyses, and anything else dependent on sequence data. BE EXTREMELY CAREFUL!!!'
		task :delete_imports => :environment do
			# This could take an extremely long time, so we need to be very strategic about the order in which we delete data.
 			# First, the big stuff that doesn't depend on anything can use raw SQL for maximum performance...
			Sample.connection.execute('DELETE FROM samples')
			
			# Now let Rails handle cascading deletes of everything else.
			Upload.destroy_all
			Import.destroy_all
		end

	
	end


end
