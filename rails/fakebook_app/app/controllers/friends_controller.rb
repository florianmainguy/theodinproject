class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_user.friends
  end
  
  def destroy(friend)
    current_user.remove_friend(friend)
    head :no_content
  end
end
