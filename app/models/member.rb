class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: {maximum: 20}, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  attachment :profile_image
  
  #通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy    # 自分からの通知  
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy   # 相手からの通知   

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
  
  def create_notification_follow!(current_member)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_member.id, id, 'follow'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end

end
