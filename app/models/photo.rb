class Photo
  include Mongoid::Document

  belongs_to :user

  mount_uploader :image, ImageUploader

  attr_accessible :image, :image_cache, :user

  validates :user, presence: true
  validates :image, presence: true

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add lambda { |photo|
      {
        small: photo.url(:thumb_small),
        medium: photo.url(:thumb_medium),
        large: photo.url(:thumb_large)
      }
    }, as: :image
  end

  def url(size = :thumb_medium)
    self.image.url(size)
  end

end