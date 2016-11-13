require 'rails_helper'

RSpec.describe Author, type: :model do
  it "should be the full name" do
  	expect(build(:author).name).to eq('Alan Turing')
  end

  it "should not validate without last name" do
    expect(Author.new(first_name: "alan", last_name: "", homepage: "http://example.com")).not_to be_valid
  end
end