class Profile
  include Mongoid::Document

  field :first_name, type: String, default: ''
  field :last_name, type: String, default: ''
  field :bio, type: String, default: ''
  field :birthday, type: Date
  field :gender, type: String, default: 'male'

  embedded_in :user

  validates :first_name, length: { in: 3..15 }, allow_blank: true
end
