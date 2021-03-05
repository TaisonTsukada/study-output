class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def self.get_likes_articles(user)
    where(user_id: user.id).map(&:article)
  end
end
