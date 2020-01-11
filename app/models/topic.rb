class Topic < ApplicationRecord
  validates :contents, presence: true
  validates :user_id, presence: true
  validates :image, presence: true
  
  belongs_to :user
  
  has_many :likes
  has_many :like_users, through: :likes, source: "user"
  has_many :comments
  
  mount_uploader :image, ImageUploader
end
