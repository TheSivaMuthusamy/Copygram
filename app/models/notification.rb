class Notification < ApplicationRecord
  validates :user_id, :subscribed_user_id, :post_id, :identifier, :notice_type, presence: true
  belongs_to :user
  belongs_to :subscribed_user, class_name: 'User'
  belongs_to :post
end
