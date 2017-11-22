module PostsHelper
  def posted_on(date)
    "Posted on #{date.strftime('%B %-d, %Y')}"
  end
end
