class Topic < ApplicationRecord
  validates :contents, presence: true
  validates :user_id, presence: true
  validates :image, presence: true
  
  belongs_to :user
  
  has_many :likes
  has_many :like_users, through: :likes, source: "user"
  has_many :comments
  
  def self.search(search)
    if search
      Topic.where(['title LIKE ? OR contents LIKE ? OR parking_info LIKE ? OR restaurant_info LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Topic.all
    end
  end
  
  mount_uploader :image, ImageUploader
end
