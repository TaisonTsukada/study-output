class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def self.likes_count(user)
   Like.find_by(user_id: user.id)
  end
end
