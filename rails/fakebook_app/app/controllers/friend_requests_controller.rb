class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create, :destroy]

  def create
    friend = User.find(params[:id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      flash[:success] = "Friend request sent"
      redirect_back(fallback_location: current_user)
    else
      flash[:success] = "Couldn't send friend request"
      redirect_back(fallback_location: current_user)
    end
  end
  
  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def destroy
    friend = User.find(params[:id])
    @friend_request = current_user.friend_requests.find_by(:friend_id, friend.id)
    @friend_request.destroy
    head :no_content
  end

  def update
    @friend_request.accept
    head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
