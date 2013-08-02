class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  has_many :photos, :dependent => :destroy
  has_many :speakers, :dependent => :destroy
=begin
  #has_many :photos, dependent: :destroy
  #has_many :friendships, inverse_of: :owner, dependent: :destroy
  #has_many :posts, inverse_of: :author, dependent: :destroy
  #has_many :notifications, inverse_of: :user, dependent: :destroy

  has_many :speakers, dependent: :destroy
  #has_and_belongs_to_many :discussions, inverse_of: nil

  validates :nickname, presence: true, length: { in: 3..15 }

  #delegate :image_url, :first_name, :last_name, :bio, :birthday, :gender, :fullname, :image_width, :image_height,
  #         :first_name=, :last_name=, :bio=, :birthday=, :gender=, :set_profile_photo,
  #         to: :profile

  attr_accessor :friend

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add :email
    t.add :nickname
    t.add :first_name
    t.add :last_name
    t.add :fullname
    t.add :bio
    t.add lambda { |user| user.birthday ? I18n.l(user.birthday) : nil }, as: :birthday
    t.add :gender
    t.add :avatar
    t.add lambda { |user| user.friend.present? ? user.friend : false }, as: :friend
  end

  api_accessible :user, extend: :angular do |t|
    t.remove :email
    t.remove :birthday
  end

  def fullname
    "#{self.first_name} #{self.nickname} #{self.last_name}".strip
  end


  def initialize(params={}, options=nil)
    profile_set = params.has_key?(:profile) || params.has_key?('profile')
    params[:profile_attributes] = params.delete(:profile) if params.has_key?(:profile) && params[:profile].is_a?(Hash)
    super
    self.profile ||= Profile.new unless profile_set
  end
=end

  def friend_status_of(user)
    friendship = self.friendships.where(friend: user).first

    statuses = Friendship.status.keys.map(&:to_s)

    friendship.present? ? statuses[friendship.status] : false
  end

  def avatar
    {
        small: { url: self.image_url(:small), width: self.image_width(:small), height: self.image_height(:small) },
        medium: { url: self.image_url(:medium), width: self.image_width(:medium), height: self.image_height(:medium) },
        large: { url: self.image_url(:large), width: self.image_width(:large), height: self.image_height(:large) }
    }
  end

end
