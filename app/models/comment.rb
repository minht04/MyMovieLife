class Comment < ApplicationRecord
  default_scope -> { order(created_at: :asc) }

  belongs_to :member
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :body, presence: true
end
