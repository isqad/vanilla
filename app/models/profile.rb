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

  delegate :url, :image_size, :to => :photo, :allow_nil => true, :prefix => true

  def avatar(size=:medium)
    self.photo_url(size) || "/assets/user/default_#{size}.jpg"
  end

  def avatar_size(size=:medium)
    self.photo_image_size(size) || case size
      when :small then '50x50'
      when :medium then '200x200'
      else '800x800'
    end
  end

  def set_profile_photo(photo)
    self.update_attributes!(:photo => photo)
  end
end
