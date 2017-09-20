class Pin < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  has_attached_file :image, styles: { medium: "700x500#", small: "350x250#" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  validates :image, presence: true
  validates :description, presence: true

  def self.search(search)
    if search
      where("description LIKE ?", "%#{search}%")
    else
      find(:all)
    end
  end

  def count_views
    self.view ||= 0
    self.view += 1
    self.save
  end
end
