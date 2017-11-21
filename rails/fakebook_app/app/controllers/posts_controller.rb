class PostsController < ApplicationController
  before_action :require_authorised_user, only: [:index]

  def index
    @posts = @user.feed_posts
  end

  def new
  end

  private
  def require_authorised_user
    @user = User.find(params[:id])
    if @user == current_user
      @new_post = Post.new
      return
    end
    unless @user.is_friend_with?(current_user)
      flash[:error] = "You're not authorized for that action."
      redirect_back(fallback_location: current_user)
    end
  end
end
