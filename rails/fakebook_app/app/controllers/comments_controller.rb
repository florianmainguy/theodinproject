class CommentsController < ApplicationController
  before_action :set_for_form

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment posted."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render :create_success }
      end
    else
      flash[:error] = "Couldn't post comment."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render partial: "shared/flash_ajax" }
      end
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_for_form
    @post = Post.new
    @comment = @post.comments.build(comment_params)
  end
end
