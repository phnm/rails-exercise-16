require 'rails_helper'

describe "Authors page", :type => :feature do
  
  it "should render" do
    visit "authors/new"
  end

  it "should have a field 'First name'" do
  	visit "authors/new"
  	expect(page).to have_field("first_name")
  end

  it "should have a 'Create Author' button" do
  	visit "authors/new"
  	expect(page).to have_button("create_author")
  end
end