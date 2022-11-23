class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id'

  after_create :update_likes_count

  private

  def update_likes_count
    post.increment!(:likes_counter)
  end
end
