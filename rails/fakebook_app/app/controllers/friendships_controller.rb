class FriendshipsController < ApplicationController
  def destroy
    @friend = User.find(params[:id])
    friendship = current_user.friendships.find_by(friend_id: @friend.id)
    friendship.destroy if friendship
    flash[:success] = "Friendship deleted"
    redirect_back(fallback_location: current_user)
  end
end
