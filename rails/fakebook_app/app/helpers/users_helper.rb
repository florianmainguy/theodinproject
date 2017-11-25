module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end

  def render_add_friend_or_unfriend(user)
    unless current_user == user
      if current_user.is_friend_with?(user)
        link_to "Unfriend", friendship_path(user), :method => :delete,
                            id: "profile-link", class: "btn btn-primary right"
      elsif current_user.has_asked_to_be_friend_with?(user)
        request_id = current_user.friend_requests.find_by(friend_id: user.id)
        link_to "Cancel request", friend_request_path(request_id,
                                  from_user: current_user, to_user: user),
                                  :method => :delete,
                                  id: "profile-link", class: "btn btn-primary right"
      elsif user.has_asked_to_be_friend_with?(current_user)
        request_id = user.friend_requests.find_by(friend_id: current_user.id)
        link_to "Decline request", friend_request_path(request_id,
                                    from_user: user, to_user: current_user),
                                    :method => :delete,
                                    id: "profile-link", class: "btn btn-primary right"
      else
        link_to "Add friend", friend_requests_path(:id => user.id), :method => :post,
                                id: "profile-link", class: "btn btn-primary right"
      end
    end
  end
end
