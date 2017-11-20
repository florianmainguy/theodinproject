class PostsController < ApplicationController
  before_action :require_current_user

  def index
  end

  private
  def require_current_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:error] = "You're not authorized for that action."
      redirect_to authenticated_root_url
    end
  end
end
