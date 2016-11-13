class Author < ActiveRecord::Base
	def name
		return first_name + ' ' + last_name
	end

	validates :last_name, presence: true
end