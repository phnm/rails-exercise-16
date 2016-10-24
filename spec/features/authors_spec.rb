require 'rails_helper'

describe "Authors page", :type => :feature do
  
  it "should render" do
    visit "authors/new"
  end
end