require 'rails_helper'

describe Post, User do
  before do
    @user = User.new(name: 'joe', posts_counter: 1)
  end

  it 'is not valid without a title' do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
  end

  it 'is not valid if comments counter is not interger' do
    post = Post.new(comments_counter: nil)
    expect(post).to_not be_valid
  end

  it 'is not valid if comments counter is not interger' do
    post = Post.new(likes_counter: nil)
    expect(post).to_not be_valid
  end

  it 'is valid if title is string and comments counter & likes counter is integer' do
    post = Post.new(author: @user, title: 'joe post', comments_counter: 1, likes_counter: 1)
    expect(post).to be_valid
  end
end
