class Comment < ApplicationRecord

  belongs_to :member
  belongs_to :post

  validates :body, presence: true


end
