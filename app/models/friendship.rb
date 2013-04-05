class Friendship
  include Mongoid::Document

  belongs_to :owner, class_name: 'User'
  belongs_to :friend, class_name: 'User'
  field :status, type: String, default: 'pending'

  validates :owner, uniqueness: { scope: :friend }
  validate :reject_self

  after_create :wait_status

  private
  def wait_status
    inverseship = Friendship.new(friend: self.owner, owner: self.friend, status: 'waiting')
    status = inverseship.save
    self.destroy if !status && inverseship.status == 'waiting' && self.status == 'pending'
  end

  def reject_self
    errors.add(:friend, :can_not_to_add_self_to_friend_list) if self.owner == self.friend
  end
end