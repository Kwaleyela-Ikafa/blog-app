require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before(:each) do
    @user = User.create(
        name: 'James',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Teacher from Mexico.'
      )
    @first_post = Post.create(author: @user, title: 'Hello, one', text: 'This is my first post')
    @second_post = Post.create(author: @user, title: 'Hello, two', text: 'This is my second post')
    @third_post = Post.create(author: @user, title: 'Hello, three', text: 'This is my third post')
    @last_post = Post.create(author: @user, title: 'Hello, four', text: 'This is my last post')
  end

  describe 'user#index' do
    before(:each) do
        @second_user = User.create(
            name: 'Ellen',
            photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
            bio: 'Teacher from Poland.'
        )
      @first_post = Post.create(author: @second_user, title: 'Hello, there', text: 'This is my first post')
      visit users_path
    end
    it 'should show username for each user' do
      expect(page).to have_content('James')
      expect(page).to have_content('Ellen')
    end

    it "should show user's profile picture" do
      expect(page.body).to include('https://unsplash.com/photos/F_-0BxGuVvo')
      expect(page.body).to include('https://unsplash.com/photos/F_-0BxGuVvo')
    end

    it 'should show the number of posts for each user' do
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_content('Number of posts: 1')
    end

    it 'should redirect the page to a user show page' do
      click_link(@second_user.name)
      expect(current_path).to eq(user_path(@second_user))
    end
  end

  describe 'user#show' do
    before(:each) do
      visit user_path(@user)
    end
    it "should show the user's profile picture" do
      expect(page.body).to include('https://unsplash.com/photos/F_-0BxGuVvo')
    end
    it 'should show username' do
      expect(page).to have_content('James')
    end

    it 'should show the number of posts the user' do
      expect(page).to have_content('Number of posts: 4')
    end

    it "should show the user's bio" do
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'should check the content of post attributes on the page' do
      expect(page).to have_current_path user_path(@user.id)
      recent_posts = @user.three_recent_posts
      recent_posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'should render see all posts button' do
      expect(page).to have_content('See all posts')
    end

    it "should check the show all posts button and it's interactions" do
      expect(page).to have_current_path user_path(@user.id)
      expect(page).to have_content('See all posts')
      click_link 'See all posts'
      expect(page).to have_current_path('/posts.15')
    end
  end
end
