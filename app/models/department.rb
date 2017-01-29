class Department < ActiveRecord::Base
	searchkick word_start: [:abbreviation, :name]

	def search_data
		{
			abbreviation: abbreviation,
			name: name
		}
	end
end
