class Post < ApplicationRecord

  belongs_to :member
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorites_by?(member)
    favorites.where(member_id: member.id).exists?
  end
end
