class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 15}
  
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, uniqueness: true,
                    format: {with: VALID_EMAIL_REGEX}
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i
  has_secure_password
  validates :password, length: {in: 8..32},
                      format: { with: VALID_PASSWORD_REGEX }, on: :create
                      
                      
  has_many :topics
  has_many :likes
  has_many :liked_topics, through: :likes, source: "topic"
  has_many :comments
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  
  
  mount_uploader :image, ImageUploader
  mount_uploader :user_background, ImageUploader
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
    
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
end
