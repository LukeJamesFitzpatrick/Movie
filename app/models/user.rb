class User < ActiveRecord::Base
  has_many :pins, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_pins, through: :likes, source: :pin
  has_many :comments, dependent: :destroy
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :name, presence: true

  if ENV['GMAIL_DOMAIN'] == 'http://gammanu.org/'
    after_create :send_alert_email
    after_create :check_to_send_mailchimp_email
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def send_alert_email
    UserMailer.delay(queue: 'email', run_at: 5.minutes.from_now).new_user_alert_email(self)
  end

  def check_to_send_mailchimp_email
    if check_mailchimp_list_for_user? && self.user_status != 'potential new member'
      mailchimp_send_email_invite
    end
  end

  def check_mailchimp_list_for_user?
    list_id = "4b2b17f02b"
    gb = Gibbon::API.new
    a = gb.lists.member_info({:id => list_id, :emails => [{:email => self.email}]})
    a["success_count"] == 0
  end

  def mailchimp_send_email_invite
    UserMailer.delay(queue: 'email', run_at: 5.minutes.from_now).mailchimp_sign_up_user_email(self)
  end

  def send_mailchimp_email
    mailchimp_send_email_invite
    redirect_to root_path, notice: "Thanks for registering for the Gamma Nu's Alumni News Letter!"
  end


  def follow(user_id)
      following_relationships.create(following_id: user_id)
    end

    def unfollow(user_id)
      following_relationships.find_by(following_id: user_id).destroy
    end

end
