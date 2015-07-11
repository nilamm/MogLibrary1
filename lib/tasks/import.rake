require 'csv'

namespace :import do
		
		desc "Import catalog from csv to Resource model" 
		task resources: :environment do
			#to execute in terminal: "rake import:resources"

		file = 'db/resource_import.csv'
			#Note: deleted header row


			CSV.foreach(file, :headers => false) do |row|
				title, composer, arranger, libretto, voice, accomp, genre, language, region, theme, curric, additional, num_tot, num_avail, res_type, link, pic, library = row
				 Resource.create(title: title,
				 	composer: composer,
				 	arranger: arranger,
				 	libretto: libretto,
				 	voice: voice,
				 	accomp: accomp,
				 	genre: genre,
				 	language: language,
				 	region: region,
				 	theme: theme,
				 	curric: curric,
				 	additional: additional,
				 	num_tot: num_tot,
				 	num_avail: num_avail,
				 	res_type: res_type,
				 	link: link,
				 	pic: pic,
				 	library: library)
			end
		end

	desc "Import users from csv to User model"
	task users: :environment do
		#to execute in terminal: "rake import:users"

	file = 'db/user_import.csv'
		#Note: deleted header row

		CSV.foreach(file, :headers => false) do |row|
			first, last, username, password, role, region = row
			User.create(
				first_name: first,
				last_name: last,
				username: username,
				password: password,
				region: region,
				role: role)
		end
	end

	desc "Import checkouts from csv to Checkout model"
	task checkouts: :environment do
		#to execute in terminal: "rake import:checkouts"

	file = 'db/import_ny_checkouts.csv'
		#Note: deleted header row

		CSV.foreach(file, :headers => false) do |row|
			num, notes, user, resource, outstanding = row
			Checkout.create(
				num_checked: num,
				notes: notes,
				user_id: user,
				resource_id: resource,
				outstanding: outstanding)
		end
	end	

end
