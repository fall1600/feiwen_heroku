module ForumsHelper
  def delete_join_leave_link
    if @forum.creater_id == current_user.id
      content_tag :a, link_to("刪除看板", fake_delete_forum_path(@forum), method: :put, :data => {confirm: "你確定嗎?"})
    elsif @forum.users.include? current_user
      content_tag :a, link_to("退出看板", leave_forum_path(@forum))
    else
      content_tag :a, link_to("加入看板", join_forum_path(@forum))
    end
  end

  def edit_forum_link
    if @forum.creater_id == current_user.id
      content_tag :a, link_to("編輯看板", edit_forum_path(@forum))  
    end
  end

  def post_a_feiwen_link
    if @forum.users.include? current_user
      content_tag :a, link_to("po 個費文", new_forum_post_path(@forum))
    end
  end
end
