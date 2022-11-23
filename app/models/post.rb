class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'

    has_many :comments
    has_many :likes

    after_create :update_posts_count
    
    def update_posts_count
        author.increment!(:posts_counter)
    end

    def five_recent_comments
        comments.order('created_at DESC').limit(5)
    end
end
