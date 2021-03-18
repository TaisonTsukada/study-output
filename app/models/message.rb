class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :dmnotifications, dependent: :destroy

  validates :message, presence: true
end
