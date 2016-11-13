describe "Paper new page", :type => :feature do
  
  it "should render" do
    visit "papers/new"
  end

 it "should have three fields: 'title', 'venue', 'year'" do
  	visit "papers/new"
    expect(page).to have_field('paper_title')
    expect(page).to have_field('paper_venue')
    expect(page).to have_field('paper_year')
  end

  it "should have a 'Create Paper' button" do
  	visit "papers/new"
  	expect(page).to have_button("Create Paper")
  end

  it "should create an instance of paper after entering data" do
    @paper = Paper.new(title: "Paper Title", venue: "Paper Venue", year: 1999)
    expect(@paper).not_to be_nil
  end

  it "form data should be found in database after submit" do
  	visit "papers/new"
  	@paper = build(:paper)
  	fill_in "Title", with: @paper.title
  	fill_in "Venue", with: @paper.venue
  	fill_in "Year", with: @paper.year
  	click_button "Create Paper"
  	expect(Paper.find_by(title: @paper.title, venue: @paper.venue, year: @paper.year)).not_to be_nil
  end

  it "should report that title or venue can't be blank" do
  	visit "papers/new"
    click_button "Create Paper"
    expect(page).to have_text ("Title can't be blank")
    expect(page).to have_text ("Venue can't be blank")
  end
end

describe "Papers index page" do
  it "should render" do
	visit "papers"
  end

  it "should contain a list of all papers with title, venue and year" do
  	@paper = build(:paper)
  	@paper.save
  	visit "papers"
  	expect(page).to have_text(@paper.title)
  	expect(page).to have_text(@paper.venue)
  	expect(page).to have_text(@paper.year)
  end

  it "should show a link to the paper page" do
    @paper = build(:paper)
    @paper.save
    visit papers_path
    expect(page).to have_link('Show', href: paper_path(@paper))
  end

  it "should link to paper edit page" do
  	@paper = build(:paper)
    @paper.save
    visit papers_path
    expect(page).to have_link('Edit', href: edit_paper_path(@paper))
  end

  it "should have a link to delete a paper" do
  	@paper = build(:paper)
    @paper.save
    visit papers_path
    expect(page).to have_link('Destroy', href: paper_path(@paper))
  end

  it "should delete the paper when clicked on Destroy" do
  	@paper = build(:paper)
    @paper.save
    visit papers_path
    click_on('Destroy')
    expect(Paper.all).to be_empty
  end

  it "should filter by year" do
    Paper.new(title: "QWERTZUI", venue: "Paper Venue", year: 1968).save
    @paper = build(:paper)
    @paper.save
    visit papers_path + "?year=1950"
    expect(page).not_to have_text("QWERTZUI")
    expect(page).to have_text(@paper.title)
  end

end

describe "Paper edit page" do
  before :each do
    @paper = build(:paper)
    @paper.save
    visit edit_paper_path(@paper)
  end

  it "should render" do
    visit edit_paper_path(@paper)
  end

  it "should save edited papers" do
    fill_in "Title", with: "Random Title"
    click_button "Update Paper"
    Paper.where(title: "Random Title", venue: "Mind 49: 433-460").take!
  end


  it "should have 5 drop down menus for Authors" do
    (1..5).each do |i|
      expect(page).to have_select("Author #{i}")
    end
  end
end

describe "Paper detail page" do
	it "should show the author's name" do
		@paper = build(:paper)
    	@paper.save
		visit paper_path(@paper)
	    @paper.authors.each do |a|
	    	expect(page).to have_text "#{a.name}"
	    end
	end

  	it "should save selected authors" do
  		@author = build(:author)
    	@author.save
		@paper = build(:paper)
    	@paper.save
    	@peter = Author.new(first_name: "Peter", last_name: "Plagiarist")
    	@peter.save
    	visit edit_paper_path(@paper)
    	select(@peter.name, from: "paper_Author 1")
    	click_button 'Update Paper'
    	expect(Paper.take!.authors).to eq [@peter]
	end
end