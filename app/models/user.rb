class User < ActiveRecord::Base
  has_many :ideas, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea
  has_many :memberships, dependent: :destroy
  has_many :idea_memberships, through: :memberships, source: :idea

  has_secure_password
  validates :password, length: {minimum: 4}, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
            on: :create

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
