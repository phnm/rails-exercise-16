require 'rails_helper'

describe "Authors new page", :type => :feature do
  
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

  it "form data should be found in database after submit" do
  	visit "authors/new"
  	@author = build(:author)
  	fill_in "First name", with: @author.first_name
  	fill_in "Last name", with: @author.last_name
  	fill_in "Homepage", with: @author.homepage
  	click_button "Create Author"
  	expect(Author.find_by(first_name: @author.first_name, last_name: @author.last_name, homepage: @author.homepage)).not_to be_nil
  end

  it "should report that last name can't be blank" do
  	visit "authors/new"
  	fill_in "First name", with: "Alan"
    fill_in "Homepage", with: "Rickman.de"
    click_button "Create Author"
    expect(page).to have_text ("Last name can't be blank")
  end
end

describe "Authors index page" do
  it "should render" do
	visit "authors"
  end

  it "should contain a list of authors with name and homepage" do
  	@author = build(:author)
  	@author.save
  	visit "authors"
  	expect(page).to have_text(@author.name)
  	expect(page).to have_link(@author.homepage)
  end

  it "should have a link to add a new author" do
  	visit "authors"
  	expect(page).to have_link('Add author', href: new_author_path)
  end

  it "should contain a link to the author page" do
    @author = build(:author)
    @author.save
    visit authors_path
    expect(page).to have_link('Show', href: author_path(@author))
  end

  it "should link to author edit page" do
  	@author = build(:author)
    @author.save
    visit authors_path
    expect(page).to have_link('Edit', href: edit_author_path(@author))
  end
end

describe "Authors edit page" do
  before :each do
    @author = build(:author)
    @author.save
    visit edit_author_path(@author)
  end

  it "should render" do
    visit edit_author_path(@author)
  end

  it "should save edited authors" do
    fill_in "First name", with: "Alan Mathison"
    click_button "Update Author"
    Author.where(first_name: "Alan Mathison", last_name: "Turing").take!
  end
end