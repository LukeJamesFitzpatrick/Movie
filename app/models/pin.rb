class Pin < ActiveRecord::Base
     belongs_to :user
     has_many :likes, dependent: :destroy
     has_many :liked_users, through: :likes, source: :user
  
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250#" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  validates :image, presence: true
  validates :description, presence: true

end
