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

  delegate :url, :size, :to => :photo, :prefix => true, :allow_nil => true

  def avatar(size = :medium)
    self.photo_url(size) || "/assets/user/default_#{size}.jpg"
  end

  def avatar_size(size = :medium)
    self.photo_size(size)
  end

  def set_profile_photo(photo)
    self.update_attributes!(:photo => photo)
  end

  def fullname
    "#{first_name} #{last_name}"
  end
end
