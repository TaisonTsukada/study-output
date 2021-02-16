class Article < ApplicationRecord
  has_rich_text :content
  with_options presence: true do
    validates :title
  end

  belongs_to :user
  has_one_attached :image


end
