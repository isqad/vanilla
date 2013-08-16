# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string(255)      default(""), not null
#  last_name  :string(255)      default(""), not null
#  user_id    :integer
#  birthday   :date
#  gender     :string(255)      default("male"), not null
#  photo_id   :integer
#  bio        :text             default(""), not null
#

class Profile < ActiveRecord::Base

  belongs_to :photo

  attr_accessible :first_name, :last_name, :bio, :birthday, :gender, :photo

  validates :first_name, :length => { in: 3..15 }, allow_blank: true
  validates :last_name, :length => { in: 3..15 }, allow_blank: true
  validates :gender, inclusion: { in: %w(male female) }, allow_blank: true
  validates :bio, :length => { maximum: 6000 }

  delegate :url, :image_width, :image_height, :image, :to => :photo, :allow_nil => true, :prefix => true

  def avatar(size=:medium)
    self.photo_url(size) || "/assets/user/default_#{size}.jpg"
  end

  def avatar_width(size=:medium)
    self.photo_image_width(size) || case size
      when :small then 50
      when :medium then 200
      else 800
    end
  end

  def avatar_height(size=:medium)
    self.photo_image_height(size) || case size
      when :small then 50
      when :medium then 200
      else 800
    end
  end

  def set_profile_photo(photo)
    Profile.transaction do
      self.photo_image.destroy if self.photo_image.present?
      self.update_attributes!(:photo => photo)
    end
  end
end
