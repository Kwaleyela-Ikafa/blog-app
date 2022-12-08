class CommentsController < ApplicationController
  def create
    @post = Post.includes(:author).find(params[:post_id])
    @post.comments.includes(:author).create(comment_parameters.merge(author_id: current_user.id))
    redirect_back(fallback_location: root_path)
  end

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
