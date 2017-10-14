class User < ActiveRecord::Base
  has_many :pins, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_pins, through: :likes, source: :pin
  has_many :comments, dependent: :destroy
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  after_create :subscribe_user_to_mailing_list

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :name, presence: true

  private

  def add_to_list
    list_id = “4b2b17f02b” @gb = Gibbon::Request.new subscribe = @gb.lists(list_id).members.create(body: { email_address: self.email, status: “subscribed”, double_optin: false })
  end

  def follow(user_id)
      following_relationships.create(following_id: user_id)
    end

    def unfollow(user_id)
      following_relationships.find_by(following_id: user_id).destroy
    end

end
