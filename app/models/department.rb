class Department < ActiveRecord::Base
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
	searchkick word_start: [:abbreviation, :name]

	def search_data
		{
			abbreviation: abbreviation,
			name: name
		}
	end
end
