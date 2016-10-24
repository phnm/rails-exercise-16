require 'rails_helper'

describe "Authors page", :type => :feature do
  
  it "should render" do
    visit new_author_path
  end
end