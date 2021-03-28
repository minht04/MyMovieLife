class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  # 通知を送る人
  belongs_to :visitor, class_name: 'Member', optional: true
  # 通知が送られる人
  belongs_to :visited, class_name: 'Member', optional: true
end
