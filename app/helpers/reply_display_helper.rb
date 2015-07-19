module ReplyDisplayHelper
  def reply_display reply
    if reply.content
      content_tag :span, "#{reply.user.try(:name)}: #{reply.content}"
    end
  end
end
