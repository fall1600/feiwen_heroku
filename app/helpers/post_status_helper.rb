module PostStatusHelper
  def post_status_signal post
    case post.status
    when "public"
      return "+"
    when "private"
      return "-"
    end
  end
end
