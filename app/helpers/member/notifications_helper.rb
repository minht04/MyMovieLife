module Member::NotificationsHelper
  # 未確認の通知を検索
  def unchecked_notifications
    @notifications = current_member.passive_notifications.where(checked: false)
  end
end
