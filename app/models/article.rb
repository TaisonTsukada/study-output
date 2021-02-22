class Article < ApplicationRecord
  has_rich_text :content
  acts_as_taggable
  belongs_to :user
  has_one_attached :image
  has_many :comments

  with_options presence: true do
    validates :title
    validates :user_id
    validates :content
    validates :tag_list
  end
end
