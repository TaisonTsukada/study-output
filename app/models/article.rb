class Article < ApplicationRecord
  has_rich_text :content
  acts_as_taggable
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :user_id
    validates :content
    validates :tag_list
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
