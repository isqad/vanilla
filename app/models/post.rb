class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  default_scope order_by(created_at: -1)

  field :body, type: String

  belongs_to :author, class_name: 'User'

  delegate :name, :image_url, to: :author, prefix: true

  validates :body, presence: true, length: { maximum: 6000 }
  validates :author, presence: true

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add :body
    t.add :created_at
    t.add lambda { |post|
      {
        id: post.author.id,
        name: post.author_name,
        avatar: {
          small: post.author_image_url(:thumb_small)
        }
      }
    }, as: :author
  end
end