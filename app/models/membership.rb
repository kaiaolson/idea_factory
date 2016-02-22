class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  def user_full_name
    user.full_name if user
  end
end
