class Notification < ActiveRecord::Base

  belongs_to :user
  belongs_to :from, :class_name => 'User', :foreign_key => 'from_id'

  attr_accessible :user, :notify

  acts_as_api

  api_accessible :angular do |t|
    t.add :id
    t.add :notify
    t.add :created_at
    t.add :from, :template => :user
  end

  def self.friend_add(user)
    I18n.t('notifications.user_wants_to_add_you_as_a_friend', username: user.nickname)
  end

  def self.friend_approve(user)
    I18n.t('notifications.user_has_added_you_as_a_friend', username: user.nickname)
  end
end
