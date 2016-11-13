class Author < ActiveRecord::Base
	def name
		return first_name + ' ' + last_name
	end
end
