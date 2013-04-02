class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  field :nickname, type: String
  ## Database authenticatable
  field :email,              :type => String, :default => ''
  field :encrypted_password, :type => String, :default => ''

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  embeds_one :profile
  has_many :photos
  has_many :friendships, inverse_of: :owner
  has_many :posts, inverse_of: :author, dependent: :destroy

  validates :nickname, presence: true, length: { in: 3..15 }

  delegate :image_url, :first_name, :last_name, :bio, :birthday, :gender,
           :first_name=, :last_name=, :bio=, :birthday=, :gender=,
           to: :profile

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add :email
    t.add :nickname
    t.add :first_name
    t.add :last_name
    t.add :bio
    t.add lambda { |user| user.birthday ? I18n.l(user.birthday) : nil }, as: :birthday
    t.add :gender
    t.add lambda { |user|
      {
        small: user.image_url(:thumb_small),
        medium: user.image_url(:thumb_medium),
        large: user.image_url(:thumb_large)
      }
    }, as: :avatar
    t.add :name
    t.add :fullname
  end

  api_accessible :user, extend: :angular do |t|
    t.remove :email
    t.remove :birthday
  end

  def initialize(params={}, options=nil)
    profile_set = params.has_key?(:profile) || params.has_key?('profile')
    params[:profile_attributes] = params.delete(:profile) if params.has_key?(:profile) && params[:profile].is_a?(Hash)
    super
    self.profile ||= Profile.new unless profile_set
  end

  def name
    if self.first_name.to_s != '' || self.last_name.to_s != ''
      "#{self.first_name} #{self.last_name}"
    else
      self.nickname
    end
  end

  def fullname
    if self.first_name.to_s != '' || self.last_name.to_s != ''
      "#{self.first_name} #{self.nickname} #{self.last_name}"
    else
      self.nickname
    end
  end

  def friend_status_of(user)
    friendship = self.friendships.where(friend: user).first
    friendship.present? ? (friendship.pending? ? 'pending' : 'friend') : nil
  end

end
