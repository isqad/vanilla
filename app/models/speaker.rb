class Speaker
  include Mongoid::Document

  attr_accessible :user, :discussion

  belongs_to :user
  belongs_to :discussion

  validates :user, :discussion, presence: true
end
