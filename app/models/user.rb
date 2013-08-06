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

  validates :username, :presence => true, length: { in: 3..15 }

  delegate :first_name,  :last_name, :avatar_size, :avatar, :fullname, :to => :profile, :allow_nil => true

  accepts_nested_attributes_for :profile

  acts_as_api

  api_accessible :angular do |t|
    t.add :id
    t.add :username
    t.add :first_name
    t.add :last_name
  end

  # Set default profile
  def initialize(params={})
    profile_set = params.has_key?(:profile) || params.has_key?("profile")
    params[:profile_attributes] = params.delete(:profile) if params.has_key?(:profile) && params[:profile].is_a?(Hash)
    super
    self.profile ||= Profile.new unless profile_set
  end

end
