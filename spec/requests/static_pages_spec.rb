require 'spec_helper'

describe "Static Pages" do
  describe "Home page" do
    it "は'Sample App'という内容が含まれてないと！" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
    end
  end

  describe "Help page" do
    it "は'Help'という内容がふくまれてないと！" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do
    it "は'About Us'という内容が含まれてないと！" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end
  end
end
