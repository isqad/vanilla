class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  default_scope order_by(created_at: -1)

  field :body, type: String

  belongs_to :author, class_name: 'User'

  delegate :id, :first_name, :last_name, :image_url, :avatar, to: :author, prefix: true

  validates :body, presence: true, length: { maximum: 6000 }
  validates :author, presence: true

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add :body
    t.add :created_at
    t.add :author, :template => :user
  end
end
