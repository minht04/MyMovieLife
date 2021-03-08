class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  attachment :profile_image
  
  # フォローしている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしている人
  has_many :follower_member, through: :followed, source: :follower
  #フォローされている人
  has_many :following_member, through: :follower, source: :followed
  
  # フォローする
  def follow(member_id)
    follower.create(followed_id: member_id)
  end
  # フォローを外す
  def unfollow(member_id)
    follower.find_by(followed_id: member_id).destroy
  end
  # すでにフォローしているかの確認
  def following?(member)
    following_member.include?(member)
  end
end
