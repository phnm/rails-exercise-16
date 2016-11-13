class Author < ActiveRecord::Base
	def name
		return first_name + ' ' + last_name
	end
	has_and_belongs_to_many :papers
	validates :last_name, presence: true
end