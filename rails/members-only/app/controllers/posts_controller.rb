class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
		if @post.save
			flash[:success] = "Post successfully created"
			redirect_to root_path
		else
			flash.now[:error] = "Title or Content cannot be empty"
			render 'new'
		end
  end

  def index
    @posts = Post.all
  end
  
  private
  
    def signed_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

		def post_params
			params.require(:post).permit(:body)
		end
end
