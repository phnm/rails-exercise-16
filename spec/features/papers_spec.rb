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

end