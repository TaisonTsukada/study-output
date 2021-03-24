class Article < ApplicationRecord
  has_rich_text :content
  acts_as_taggable
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stock_users, through: :stocks, source: :user

  is_impressionable counter_cache: true

  with_options presence: true do
    validates :title, length: { maximum: 25 }
    validates :user_id
    validates :content
    validates :tag_list
  end
  validate :tag_list_tag_validation

  def tag_list_tag_validation
    tag_validation = tag_list # validatesの時と違って、:tag_listとしないところを注意
    tag_validation.split(',')
    errors.add(:tag_list, 'を入力してください') if tag_validation.length < 1
    errors.add(:tag_list, 'は５個までです') if tag_validation.length > 5
  end

  # 通知機能のメソッド↓
  def create_notification_like!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and article_id = ? and action = ? ', current_user.id, user_id,
                               id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: 'like'
      )
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  # ストック機能のメソッド↓
  def stock(user)
    stocks.create(user_id: user.id)
  end

  def unstock(user)
    stocks.find_by(user_id: user.id).destroy
  end

  def stocked?(user)
    stock_users.include?(user)
  end
end
