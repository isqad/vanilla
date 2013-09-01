# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null
#  friend_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(255)      default("pending")
#

class Friendship < ActiveRecord::Base
  include Workflow

  attr_accessible :friend_id, :owner_id, :state

  belongs_to :owner, :class_name => 'User'
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'

  validates :owner_id, :friend_id, :presence => true
  validates :owner_id, :uniqueness => { scope: :friend_id }
  validate :reject_self

  workflow_column :state
  workflow do
    state :pending do
      event :accept, :transitions_to => :friends
      event :reject, :transitions_to => :subscriber
    end
    state :subscriber
    state :friends
  end

  private
  def reject_self
    errors.add(:friend, :can_not_to_add_self_to_friend_list) if self.owner == self.friend
  end
end
