require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  before(:each) do
    @first_user = User.create(
      name: 'James',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
    @second_user = User.create(
      name: 'Ellen',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Poland.'
    )
    @first_post = Post.create(author: @first_user, title: 'Hello, one', text: 'This is my first post')
    @second_post = Post.create(author: @first_user, title: 'Hello, two', text: 'This is my second post')
    @third_post = Post.create(author: @first_user, title: 'Hello, three', text: 'This is my third post')
    @last_post = Post.create(author: @first_user, title: 'Hello, four', text: 'This is my last post')
    @comment1 = Comment.create(post: @last_post, author: @second_user,
                               text: 'This is the 1st comment on the last post')
    @comment2 = Comment.create(post: @last_post, author: @second_user,
                               text: 'This is the 2nd comment on the last post')
    @comment3 = Comment.create(post: @last_post, author: @second_user,
                               text: 'This is the 3rd comment on the last post')
  end

  describe 'post#index' do
    before(:each) do
      visit user_posts_path(@first_user)
    end
    it 'should show username for a user' do
      expect(page).to have_content('James')
    end

    it "should show user's profile picture" do
      expect(page.body).to include('https://unsplash.com/photos/F_-0BxGuVvo')
    end

    it 'should show the number of posts for each user' do
      expect(page).to have_content('Number of posts: 4')
    end

    it "should show the post's title" do
      expect(page).to have_content('Hello, one')
      expect(page).to have_content('Hello, two')
      expect(page).to have_content('Hello, three')
    end

    it 'should display the first comments on a post' do
      expect(page).to have_content('This is the 1st comment on the last post')
      expect(page).to have_content('This is the 2nd comment on the last post')
      expect(page).to have_content('This is the 3rd comment on the last post')
    end

    it 'how many comments a post has.' do
      expect(page).to have_content('Comments: 3')
    end

    it 'how many likes a post has.' do
      expect(page).to have_content('Likes: 0')
    end

    it 'should show a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content('Pagination')
    end

    it "should redirect to that post's show page when clicked" do
      click_link(@first_post.title)
      expect(page).to have_current_path('/posts/69')
    end
  end

  describe 'post#show' do
    before(:each) do
      visit user_post_path(@first_user.id, @last_post.id)
    end

    it "should have post's title, author" do
      expect(page).to have_content(@last_post.title)
      expect(page).to have_content('James')
    end

    it 'how many comments a post has.' do
      expect(page).to have_content("Comments: #{@last_post.comments_counter}")
    end

    it 'how many likes a post has' do
      expect(page).to have_content("Likes: #{@last_post.likes_counter}")
    end

    it 'should some of the posts body' do
      expect(page).to have_content(@last_post.text)
    end

    it "should show the comment's author" do
      expect(page).to have_content(@comment1.author.name)
      expect(page).to have_content(@comment2.author.name)
      expect(page).to have_content(@comment3.author.name)
    end

    it "should show the comment's for each user" do
      @second_user.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
