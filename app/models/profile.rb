class Profile < ActiveRecord::Base

  belongs_to :photo

  attr_accessible :first_name, :last_name, :bio, :birthday, :gender, :photo

  validates :first_name, length: { in: 3..15 }, allow_blank: true
  validates :last_name, length: { in: 3..15 }, allow_blank: true
  validates :gender, inclusion: { in: %w(male female) }, allow_blank: true
  validates :bio, length: { maximum: 6000 }

  delegate :url, :width, :height, to: :photo, prefix: true, allow_nil: true

  def image_url(size = :medium)
    self.photo_url(size) || "/assets/user/default_#{size}.jpg"
  end

  def image_width(size = :medium)
    self.photo_width(size)
  end

  def image_height(size = :medium)
    self.photo_height(size)
  end

  def set_profile_photo(photo)
    self.update_attributes!(:photo => photo)
  end

  def fullname
    "#{first_name} #{last_name}"
  end
end
