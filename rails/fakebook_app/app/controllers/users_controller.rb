class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    user_search = params[:search].split(" ")
    if user_search.count > 1
      @users = User.search_by_full_name(user_search)
    else
      @users = User.search(user_search[0])
    end 
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def photo
    @user = current_user
  end

  private

    def user_params
      params.require(:user).permit(:content)
    end
end
