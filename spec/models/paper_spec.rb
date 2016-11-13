require 'rails_helper'

RSpec.describe Paper, type: :model do
    it "should not validate without title and venue" do
	    expect(Paper.new(title: "alan", venue: "", year: 1999).save).to be false
	    expect(Paper.new(title: nil, venue: "dort", year: 1999).save).to be false
   end
end