class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :memberships
  has_many :users, through: :likes

  # has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "https://upload.wikimedia.org/wikipedia/commons/4/47/Comic_image_missing.png"
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true

  def user_full_name
    user.full_name if user
  end

  def like_for(user)
    likes.find_by_user_id user
  end

  def membership_for(user)
    memberships.find_by_user_id user
  end
end
