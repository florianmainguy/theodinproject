class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
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
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render :destroy_success }
      end
    else
      flash[:error] = "Couldn't delete comment."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render partial: "shared/flash_ajax" }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def define_comment
    @comment = Comment.find(params[:comment_id])
  end
end
