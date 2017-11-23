module CommentsHelper
  def render_delete_link(comment)
    if current_user == comment.commenter
      path = post_comment_path(comment.post.id,
                               comment.id)
      content_tag(:span, class: "inline pull-right") do
        link_to("Delete", path, :method => :delete, :remote => true)
      end
    end
  end
end
