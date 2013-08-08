# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  username               :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_one :profile, :dependent => :destroy

  has_many :photos, :dependent => :destroy
  has_many :speakers, :dependent => :destroy

  has_many :friendships, :foreign_key => 'owner_id'
  has_many :friends, :through => :friendships, :source => :user

  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :posts, :dependent => :destroy, :foreign_key => 'author_id', :include => :author

  validates :username, :presence => true, length: { in: 3..15 }

  delegate :first_name,  :last_name, :photo, :bio, :birthday, :gender, :avatar, :avatar_width, :avatar_height, :set_profile_photo, :to => :profile, :allow_nil => true

  accepts_nested_attributes_for :profile

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
      }
    }, :as => :avatar
    t.add :bio
    t.add :gender
    t.add :birthday
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

end
