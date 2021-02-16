class Article < ApplicationRecord
  has_rich_text :sentence
  with_options presence: true do
    validates :title
    validates :sentence
    validates :user_id

    belongs_to :user
    has_one_attached :image

  end
end
