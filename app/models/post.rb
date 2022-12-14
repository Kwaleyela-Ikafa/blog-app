class Post < ApplicationRecord
  after_save :update_posts_count
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  validates :title, presence: true
  validates_length_of :title, minimum: 2, maximum: 250
  validates_numericality_of :comments_counter, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :likes_counter, only_integer: true, greater_than_or_equal_to: 0

  def update_posts_count
    author.increment!(:posts_counter)
  end

  def five_recent_comments
    Comment.includes(:author).where(post_id: id).last(5)
  end
end
