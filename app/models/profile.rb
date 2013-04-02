class Profile
  include Mongoid::Document

  field :first_name, type: String, default: ''
  field :last_name, type: String, default: ''
  field :bio, type: String, default: ''
  field :birthday, type: Date
  field :gender, type: String, default: 'male'
  field :image_url, type: String
  field :image_url_small, type: String
  field :image_url_large, type: String

  embedded_in :user

  attr_accessible :first_name, :last_name, :bio, :birthday, :gender,
                  :image_url, :image_url_small, :image_url_large

  validates :first_name, length: { in: 3..15 }, allow_blank: true
  validates :last_name, length: { in: 3..15 }, allow_blank: true
  validates :gender, inclusion: { in: %w(male female) }, allow_blank: true
  validates :bio, length: { maximum: 6000 }

  def image_url(size = :thumb_medium)
    result = if size == :thumb_medium && self[:image_url_medium]
        self[:image_url_medium]
      elsif size == :thumb_small && self[:image_url_small]
        self[:image_url_small]
      else
        self[:image_url]
      end

    result || "/assets/user/default_#{size}.jpg"
  end

  def set_photo(photo)
    profile_params = {
                        image_url: photo.url(:thumb_medium),
                        image_url_large: photo.url(:thumb_large),
                        image_url_small: photo.url(:thumb_small)
                      }
    self.update_attributes!(profile_params)
  end
end
