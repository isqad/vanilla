class Discussion
  include Mongoid::Document

  attr_accessor :recipient_ids

  embeds_many :speakers
  has_many :messages, dependent: :destroy

  after_create :add_recipients


  private
  def add_recipients
    if recipient_ids.kind_of?(Array)
      recipient_ids.uniq!
      recipient_ids.each do |id|
        recipient = User.where(:id => id).first
        add_speaker(recipient) if recipient
      end
    end
  end

  def add_speaker(user)
    Speaker.create!(:discussion => self, :user => user)
  end
end
