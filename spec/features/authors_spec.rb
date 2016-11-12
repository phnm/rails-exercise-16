require 'rails_helper'

describe "Authors page", :type => :feature do
  
  it "should render" do
    visit "authors/new"
  end

  it "should have three fields: 'first name', 'last name', 'homepage'" do
  	visit "authors/new"
    expect(page).to have_field('author_first_name')
    expect(page).to have_field('author_last_name')
    expect(page).to have_field('author_homepage')
  end

  it "should have a 'Create Author' button" do
  	visit "authors/new"
  	expect(page).to have_button("Create Author")
  end
end