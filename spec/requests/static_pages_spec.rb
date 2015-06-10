require 'spec_helper'

describe "Static Pages" do

  let (:base_title) {"Ruby on Rails Tutorial Sample App"}

  describe "Home page" do
    it "は'Sample App'という内容が含まれてないと！" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title}")
    end

    it "はタイトルに'| Home'を含まないこと！" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help page" do
    it "は'Help'という内容がふくまれてないと！" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
    it "は'About Us'という内容が含まれてないと！" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/about'
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "Contact" do
    it "は'Contact'という内容がふくまれてないと！" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end

    it "は正しいタイトルになってないと！" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end
