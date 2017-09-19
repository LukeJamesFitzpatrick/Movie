class User < ActiveRecord::Base
  	has_many :pins, dependent: :destroy
  	has_many :likes, dependent: :destroy
  	has_many :liked_pins, through: :likes, source: :pin

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :name, presence: true

  # def self.search(search)
  #   if search
  #     where("username LIKE ?", "%#{search}%")
  #   else
  #     find(:all)
  #   end
  # end
end
