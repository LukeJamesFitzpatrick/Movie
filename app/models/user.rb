class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :pins, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_pins, through: :likes, source: :pin

	validates :name, presence: true
end


