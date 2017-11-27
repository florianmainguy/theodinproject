class FriendRequestsController < ApplicationController
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
    @from_user = User.find(params[:from_user])
    @to_user = User.find(params[:to_user])
    @friend_request = @from_user.friend_requests.find_by(friend_id: @to_user.id)
    @friend_request.destroy
    flash[:success] = "Friend request deleted"
    redirect_back(fallback_location: current_user)
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.accept
    flash[:success] = "Friend request accepted"
    redirect_back(fallback_location: current_user)
  end
end
