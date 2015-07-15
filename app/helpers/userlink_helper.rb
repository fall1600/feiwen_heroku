module UserlinkHelper
  def user_link post, userid
    username = post.user.try(:name)
    userid ||= -1
    content_tag :a, link_to(username, userid)
  end
end
