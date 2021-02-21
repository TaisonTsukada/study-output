class ArticlesTag
  include ActiveModel::Model
  attr_accessor :title, :name, :user_id
  attr_writer :content

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :name, length: { maximum: 10 }
    validates :content, length: { maximum: 500 }
    validates :user_id
  end

  def initialize(attributes = {})
    super
    set_article
  end

  def save
    @article.save
    tag = Tag.find_or_create_by(name: name)

    ArticleTagRelation.create(article_id: @article.id, tag_id: tag.id)
  end

  def content
    @article.content
  end

  def set_article
    @article = Article.new(title: title, content: @content)
  end
end
