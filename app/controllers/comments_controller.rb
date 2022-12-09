class CommentsController < ApplicationController
  def create
    @post = Post.includes(:author).find(params[:post_id])
    @post.comments.includes(:author).create(comment_parameters.merge(author_id: current_user.id))
    redirect_back(fallback_location: :authenticated_root)
  end

  def comment_parameters
    params.require(:comment).permit(:text)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)
    @comment.destroy!
    flash[:success] = 'The comment was successfully deleted.'
    redirect_to user_posts_path(current_user)
  end
end
