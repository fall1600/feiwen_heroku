module ForumsHelper

  def action_link
    find_ship
    case @ship.try(:status)
    when "hosting"
      content_tag :a, link_to("編輯看板", edit_forum_path(@forum))
    when "joined"
      content_tag :a, link_to("退出看板", leave_forum_path(@forum))
    when "pending"
      content_tag :a, link_to("取消申請", cancel_forum_path(@forum))
    when "bucketed"
      content_tag :a, link_to("退出看板", leave_forum_path(@forum))
    else
      content_tag :a, link_to("加入看板", join_forum_path(@forum))
    end
  end

  def post_a_feiwen_link
    find_ship
    if @ship.try(:status) == "hosting" || @ship.try(:status) == "joined"
      content_tag :a, link_to("po 個費文", new_forum_post_path(@forum))
    end
  end

  protected

  def find_ship
    @ship = ForumUsership.find_by_forum_id_and_user_id(@forum, current_user)
  end
end
