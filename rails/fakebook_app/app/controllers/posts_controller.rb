class PostsController < ApplicationController
  before_action :require_authorised_user, only: [:index]

  def index
    @posts = @user.feed_posts
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post has been created."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render :create_success }
      end
    else
      flash[:error] = "Couldn't create post."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render partial: "shared/flash_ajax" }
      end
    end
  end

  def destroy
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

  def post_params
    params.require(:post).permit(:body)
  end
end
