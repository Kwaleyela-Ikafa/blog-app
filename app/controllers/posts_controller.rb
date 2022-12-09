class PostsController < ApplicationController
  def show
    @post = Post.includes(:author).find(params[:id])
    # @user = User.find(@post.author_id)
    @user = current_user
    @comments = Comment.includes(:author).where(post_id: @post.id)
  end

  def index
    @user = current_user
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    new_post = Post.new
    new_post.author_id = current_user.id
    new_post.title = params[:title]
    new_post.text = params[:text]
    new_post.save
    redirect_back(fallback_location: :authenticated_root)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post).permit(:title, :text))
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)
    @post.destroy
    flash[:success] = 'Post was successfully deleted'
    redirect_to user_path(@post.author)
  end
end
