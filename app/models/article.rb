class Article < ApplicationRecord
  has_rich_text :content
  belongs_to :user
  has_one_attached :image
  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations
end
