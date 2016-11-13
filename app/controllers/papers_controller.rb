class PapersController < ApplicationController
	def new
		@paper = Paper.new
	end
end
