module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end

  def render_add_friend_or_unfriend(user)
    if current_user.is_friend_with?(user)
      link_to "Unfriend", friends_destroy_path(user), 
                          id: "profile-link", class: "btn btn-primary right"
    else
      if current_user.has_asked_to_be_friend_with?(user)
        link_to "Cancel request", friend_request_path(user), :method => :delete,
                              id: "profile-link", class: "btn btn-primary right"
      else
        link_to "Add friend", friend_requests_path(:id => user.id), :method => :post,
                              id: "profile-link", class: "btn btn-primary right"
      end
    end
  end
end
