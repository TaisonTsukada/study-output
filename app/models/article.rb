class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
    validates :user_id

    belongs_to :user
    has_one_attached :image

  end
end
