class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
    validates :image
    validates :user_id

    belongs_to :user

  end
end
