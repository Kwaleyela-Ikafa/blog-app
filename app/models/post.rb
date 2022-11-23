class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  after_create :update_posts_count

  def update_posts_count
    author.increment!(:posts_counter)
  end

  def five_recent_comments
    comment.order('created_at DESC').limit(5)
  end
end
