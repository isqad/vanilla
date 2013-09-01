# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_meta         :text
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Photo < ActiveRecord::Base
  attr_accessible :image, :user

  belongs_to :user

  has_attached_file :image, :styles => {
    :medium => ['220x', :jpg],
    :thumb => ['120x', :jpg],
    :small => ['50x', :jpg],
    :large => ['800x', :jpg]
  },
  :convert_options => {
    :medium => '-strip -gravity north -crop 220x340+0+0 +repage',
    :small => '-strip -gravity north -crop 50x50+0+0 +repage',
    :large => '-strip',
    :thumb => '-strip -gravity north -crop 120x90+0+0 +repage'
  },
  :default_url => '/assets/user/default_:style.jpg',
  :url => "/system/:user_id/:class/:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/:user_id/:class/:id/:style/:filename"

  validates :user, presence: true
  validates_attachment :image, presence: true, :size => { :less_than => 10.megabytes }

  acts_as_api

  api_accessible :angular do |t|
    t.add :id
    t.add lambda { |photo|
      {
        small: { url: photo.url(:small), width: photo.image.width(:small), height: photo.image.height(:small) },
        medium: { url: photo.url(:medium), width: photo.image.width(:medium), height: photo.image.height(:medium) },
        large: { url: photo.url(:large), width: photo.image.width(:large), height: photo.image.height(:large) },
        thumb: { url: photo.url(:thumb), width: photo.image.width(:thumb), height: photo.image.height(:thumb) }
      }
    }, :as => :image
  end

  def url(size = :medium)
    self.image.url(size)
  end

  def image_width(size = :medium)
    self.image.width(size)
  end

  def image_height(size = :medium)
    self.image.height(size)
  end

  Paperclip.interpolates :user_id do |attachment, style|
    "user_#{attachment.instance.user_id}"
  end

end
