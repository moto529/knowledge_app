class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable
  has_many :knowledges, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :favorites,  dependent: :destroy
  has_many :favorite_knowledges, through: :favorites, source: :knowledge
  
  mount_uploader :profile_image, ProfileImageUploader
  
  validates :introduction, presence: false, length: { maximum: 150 }

  # フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  def favorite(knowledge)
    favorite_knowledges << knowledge
  end
  
  def unfaborite(knowledge)
    favorite_knowledges.destroy(knowledge)
  end
  
  def favorite?(knowledge)
    favorite_knowledges.include?(knowledge)
  end
end
