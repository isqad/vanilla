class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :body, type: String

  default_scope order_by(created_at: -1)

  belongs_to :discussion
  belongs_to :user
end
