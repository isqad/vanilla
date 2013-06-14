class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :body, type: String

  attr_accessible :body, :discussion, :user

  default_scope order_by(created_at: -1)

  belongs_to :discussion
  belongs_to :user
end
