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
        small: { url: photo.url(:small), width: photo.image_width(:small), height: photo.image_height(:small) },
        medium: { url: photo.url(:medium), width: photo.image_width(:medium), height: photo.image_height(:medium) },
        large: { url: photo.url(:large), width: photo.image_width(:large), height: photo.image_height(:large) },
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
