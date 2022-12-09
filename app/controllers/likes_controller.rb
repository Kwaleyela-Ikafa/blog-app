class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(author_id: current_user.id)
    redirect_back(fallback_location: :authenticated_root)
  end
end
