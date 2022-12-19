module Public::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @whiskey_comment = nil
    @visitor_comment = notification.whiskey_comment_id
    case notification.action
    when 'favorite'
      tag.a(notification.visitor.name) + 'が' + tag.a('あなたの投稿', href: whiskey_path(notification.whiskey_id)) + 'にいいねしました'
    when 'whiskey_comment' then
      @whiskey_comment = WhiskeyComment.find_by(id: @visitor_comment)
      @whiskey_name = @whiskey_comment.whiskey.name
      tag.a(@visitor.name) + 'が' + tag.a("#{@whiskey_name}", href: whiskey_path(notification.whiskey_id)) + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
