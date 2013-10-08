# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)      default(""), not null
#  username           :string(255)
#  encrypted_password :string(255)      default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  last_response_at   :datetime
#  persistence_token  :string(255)      not null
#

class User < ActiveRecord::Base

  attr_accessible :email, :username

  has_one :profile, :dependent => :destroy

  has_many :photos, :dependent => :destroy
  has_many :speakers, :dependent => :destroy

  has_many :friendships, :foreign_key => 'owner_id'
  has_many :friends, :through => :friendships, :source => :friend

  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :posts, :dependent => :destroy, :include => :author, :order => 'created_at DESC'

  has_many :notifications, :dependent => :destroy, :order => 'created_at DESC'

  validates :username, :presence => true, length: { in: 3..15 }, :uniqueness => true

  delegate :first_name,  :last_name, :photo, :bio, :birthday, :age, :gender, :avatar, :avatar_width, :avatar_height, :set_profile_photo, :to => :profile, :allow_nil => true

  accepts_nested_attributes_for :profile

  scope :online, lambda { where('last_response_at > ?', 10.minutes.ago) }
  scope :without_me, lambda { |me| where('id <> ?', me.id) }
  scope :ordered, order('last_response_at IS NULL, last_response_at DESC')

  acts_as_authentic do |config|
    # Login via email
    config.login_field = :email
  end

  acts_as_api

  api_accessible :angular do |t|
    t.add :id
    t.add :username
    t.add :email
    t.add :first_name
    t.add :last_name
    t.add :fullname
    t.add lambda { |u|
      {
        small: { url: u.avatar(:small), width: u.avatar_width(:small), height: u.avatar_height(:small) },
        medium: { url: u.avatar(:medium), width: u.avatar_width(:medium), height: u.avatar_height(:medium) },
        large: { url: u.avatar(:large), width: u.avatar_width(:large), height: u.avatar_height(:large) },
        thumb: { url: u.avatar(:thumb), width: u.avatar_width(:thumb), height: u.avatar_height(:thumb) }
      }
    }, :as => :avatar
    t.add :bio
    t.add :gender
    t.add :birthday
    t.add :last_response_at
    t.add :age
    t.add :online
  end

  api_accessible :user, :extend => :angular do |t|
    t.remove :email
  end

  # Set default profile
  def initialize(params={})
    profile_set = params.has_key?(:profile) || params.has_key?("profile")
    params[:profile_attributes] = params.delete(:profile) if params.has_key?(:profile) && params[:profile].is_a?(Hash)
    super
    self.profile ||= Profile.new unless profile_set
  end

  def fullname
    "#{first_name} #{username} #{last_name}".strip
  end

  def online
    return false unless self.last_response_at.present?
    self.last_response_at > 10.minutes.ago
  end

  def deliver_password_instructions!

  end

end
