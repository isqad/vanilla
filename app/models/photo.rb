class Photo < ActiveRecord::Base
  attr_accessible :image, :user

  belongs_to :user

  validates :user, presence: true
  validates_attachment :image, presence: true, :size => { :less_than => 10.megabytes }

  has_attached_file :image, :styles => {
    :medium => '200x120>',
    :small => '50x50',
    :large => '800x600>'
  },
  :url => "/system/:class/:id/:style//:basename.:extension",
  :path => ":rails_root/public/system/:class/:id/:style/:filename"

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
