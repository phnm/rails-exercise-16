require 'rails_helper'

RSpec.describe Author, type: :model do
  it "should be the full name" do
  	expect(build(:author).name).to eq('Alan Turing')
  end
end