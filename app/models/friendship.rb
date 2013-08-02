class Friendship < ActiveRecord::Base

  STATUS = { :pending => 0, :waiting => 1, :friend => 2}.freeze

  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :friend, :class_name => 'User', :foreign_key => 'owner_id'

  #has_one :friendship, inverse_of: :inverseship
  # Другая сторона связи
  belongs_to :inverseship, :class_name 'Friendship', :foreign_key => 'inversible_id'

  validates :owner, uniqueness: { scope: :friend }
  validate :reject_self

  before_create :wait_status

  before_save :friend_status

  after_destroy :delete_inverseship

  scope :friends, lambda { where(:status => STATUS[:friend]) }

  class << self
    def status
      STATUS
    end
  end

  private

  # Создаем на другой стороне связь со статусом ожидания
  # Только если эта сторона имеет статус pending (не реализована)
  # После этого сторона, отправившая предложение имеет статус pending
  # Получатель дружбы имеет связь с этой стороной со статусом waiting
  def wait_status
    if self.status == STATUS[:pending]
      self.inverseship = Friendship.create(friend: self.owner, owner: self.friend, status: STATUS[:waiting], inverseship: self)

      if self.inverseship
        notification = Notification.new
        notification.from = self.owner
        notification.user = self.friend
        notification.notify = Notification.friend_add(self.owner)
        notification.save!
      end
    end
  end

  # Статус дружбы
  # Вторая сторона принимает либо отклоняет дружбу
  def friend_status
    inverse = self.friendship

    if inverse.present? && inverse.status == STATUS[:pending] && self.status == STATUS[:friend]
      if inverse.update_attributes(status: STATUS[:friend])
        notification = Notification.new
        notification.from = self.owner
        notification.user = self.friend
        notification.notify = Notification.friend_approve(self.owner)
        notification.save!
      end
    end
  end

  def delete_inverseship
    inverse = self.friendship
    inverse.destroy if inverse.present?
  end

  def reject_self
    errors.add(:friend, :can_not_to_add_self_to_friend_list) if self.owner == self.friend
  end
end
