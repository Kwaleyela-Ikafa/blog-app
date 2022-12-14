class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(author_id: @user.id)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :photo, :bio))
  end

  def update
    @user = User.find(params[:id])
    @user.update(params.require(:user).permit(:name, :photo, :bio))
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end
