module LikesHelper
   def render_like_link(likeable)
    if nil
      link_to("Unlike",
        like_path(likeable.likes.find_by_user_id(current_user.id)),
        class: "like-link pull-left",
        :method => :delete, :remote => true)
    else
      link_to("Like",
        likes_path(:like => { likeable_type: likeable.class,
                              likeable_id: likeable.id }),
        class: "like-link pull-left",
        :method => :post, :remote => true)
    end
  end
end
