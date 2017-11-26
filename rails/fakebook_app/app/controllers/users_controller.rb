class UsersController < ApplicationController
  before_action :set_user, except: [:new]

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
  end

  def photo
  end

  def friends
    @friends = @user.friends
  end

  private
    def set_user
      if params[:id]
        @user = User.find(params[:id])
      else
        @user = current_user
      end
    end
end
