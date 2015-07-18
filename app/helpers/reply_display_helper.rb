module ReplyDisplayHelper
  def reply_display reply
    content_tag :li, "#{reply.user.name}: #{reply.content}"
  end
end
