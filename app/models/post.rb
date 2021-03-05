class Post < ApplicationRecord

  belongs_to :member
  attachment :image
  has_many :comments, dependent: :destroy
end
