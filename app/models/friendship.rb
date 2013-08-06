class Friendship < ActiveRecord::Base

  STATUS = { :pending => 0, :waiting => 1, :friend => 2}.freeze

  belongs_to :owner, :class_name => 'User'
  belongs_to :friend, :class_name => 'User'

  validates :owner_id, :uniqueness => { scope: :friend_id }
  validate :reject_self

  scope :friends, lambda { where(:status => STATUS[:friend]) }

  private
  def reject_self
    errors.add(:friend, :can_not_to_add_self_to_friend_list) if self.owner == self.friend
  end
end
