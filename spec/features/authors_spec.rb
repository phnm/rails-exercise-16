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

  it "should create an instance of Author after entering data" do
    @author = Author.new(first_name: "Alan", last_name: "Turing", homepage: "http://wikipedia.org/Alan_Turing")
    expect(@author).not_to be_nil
  end

  it "should be found in database" do
  	visit "authors/new"
  	@author = build(:author)
  	fill_in "First name", with: @author.first_name
  	fill_in "Last name", with: @author.first_name
  	fill_in "Homepage", with: @author.first_name
  	click_button "Create Author"
  	expect(Author.find_by(first_name: @author.first_name, last_name: @author.last_name, homepage: @author.homepage)).not_to be_nil
  end
end