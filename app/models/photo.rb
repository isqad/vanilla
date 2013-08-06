class Photo < ActiveRecord::Base
  attr_accessible :image, :user

  belongs_to :user

  has_attached_file :image, :styles => {
    :medium => '200x120>',
    :small => '50x50',
    :large => '800x600>'
  },
  :default_url => '/assets/user/default_:style.jpg',
  :url => "/system/:class/:id/:style//:basename.:extension",
  :path => ":rails_root/public/system/:class/:id/:style/:filename"

  validates :user, presence: true
  validates_attachment :image, presence: true, :size => { :less_than => 10.megabytes }

  acts_as_api

  api_accessible :angular do |t|
    t.add :id
    t.add lambda { |photo|
      {
        small: { url: photo.url(:small), size: photo.image_size(:small) },
        medium: { url: photo.url(:medium), size: photo.image_size(:medium) },
        large: { url: photo.url(:large), size: photo.image_size(:large) },
      }
    }, :as => :image
  end

  def url(size = :medium)
    self.image.url(size)
  end

  def image_size(size = :medium)
    self.image.image_size(size)
  end

end
