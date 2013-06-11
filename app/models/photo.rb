class Photo
  include Mongoid::Document

  field :image_small_width, type: Integer
  field :image_small_height, type: Integer
  field :image_medium_width, type: Integer

  field :image_medium_height, type: Integer
  field :image_large_width, type: Integer
  field :image_large_height, type: Integer

  belongs_to :user

  mount_uploader :image, ImageUploader

  attr_accessible :image, :image_cache, :user
  attr_accessible :image_small_width, :image_small_height
  attr_accessible :image_medium_width, :image_medium_height
  attr_accessible :image_large_width, :image_large_height

  validates :user, presence: true
  validates :image, presence: true

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add lambda { |photo|
      {
        small: { url: photo.url(:small), width: photo.width(:small), height: photo.height(:small) },
        medium: { url: photo.url(:medium), width: photo.width(:medium), height: photo.height(:medium) },
        large: { url: photo.url(:large), width: photo.width(:large), height: photo.height(:large)},
      }
    }, as: :image
  end

  def url(size = :medium)
    self.image.url(size)
  end

  def width(size = :medium)
    self.send("image_#{size}_width".to_sym)
  end

  def height(size = :medium)
    self.send("image_#{size}_height".to_sym)
  end

end
