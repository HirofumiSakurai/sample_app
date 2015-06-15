require 'spec_helper'

describe "MicropostPages" do

  subject {page}

  let (:user) {FactoryGirl.create(:user)}
  before { sign_in user }
  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post"}.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before {click_button "Post"}
        it {should have_content('error')}
      end
    end

    it { should have_content('0 microposts')}

    describe "with valid information" do
      before do
        fill_in 'micropost_content', with: "Lerem ipsum"
      end
      it "should create a micropost" do
        expect {click_button("Post")}.to change(Micropost, :count). by(1)
      end

      describe "should have correct micropost count" do
        before { click_button "Post"}

        it { should have_content('1 micropost')}

        describe "with another post" do
          before do
            fill_in 'micropost_content', with: "test, again"
            click_button "Post"
          end
          it { should have_content('2 microposts')}
        end
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user)}

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect {click_link "delete"}.to change(Micropost, :count).by(-1)
      end
    end
  end
end

describe "with many microposts" do
  subject {page}

  before(:all) do
    @user = FactoryGirl.create(:user)
    @microposts = 50.times {FactoryGirl.create(:micropost, user: @user, content: "test")}
    visit root_path
  end
  after(:all) do
    @user.microposts.each do |micropost|
      micropost.destroy
    end
    @user.destroy
  end

  describe "pagination" do
    before {sign_in @user}
    it {should have_selector('div.pagination')}
  end

  # it "should list each microposts" do
  #   @user.microposts.paginate(page:1).each do |micropost|
  #     expect(page).to have_selector('li', text: micropost.content)
  #   end
  # end

  describe "exist delete link on current user" do
    before do
      sign_in @user
    end
    it {should have_content('delete')}
  end

  describe "no delete link on other user's login" do
    let (:other_user) {FactoryGirl.create(:user)}
    before do
      sign_in other_user
    end
    it {should_not have_content('delete')}
  end
end
