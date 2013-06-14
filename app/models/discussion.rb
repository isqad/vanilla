class Discussion
  include Mongoid::Document

  attr_accessible :messages_attributes, :speakers_attributes

  has_many :speakers, dependent: :destroy
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages, :speakers

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add :speakers
  end

  def self.find_between_users(user, user2)
    dialog = nil

    speakers = Speaker.where('user_id = ?', user.id)

    discussions = speakers.map{|s| s.discussion }

    discussions.each do |discussion|
      disc_users = discussion.speakers.map{ |s| s.user }
      dialog = discussion if discussion.private? && ([disc_users.first, disc_users.last] - [user, user2]).empty?
    end
    dialog
  end

  def private?
    self.speakers.size == 2
  end
end
