require 'rails_helper'

RSpec.describe Paper, type: :model do
    it "should not validate without title and venue and year" do
	    expect(Paper.new(title: "alan", venue: "", year: 1999).save).to be false
	    expect(Paper.new(title: nil, venue: "dort", year: 1999).save).to be false
	    expect(Paper.new(title: "alan", venue: "dort", year: nil).save).to be false
	    expect(Paper.new(title: "alan", venue: "dort", year: "#").save).to be false
   end

    it "should have an empty list of authors" do
    	@paper = Paper.new
    	expect(@paper.authors).to eq []
	end
end