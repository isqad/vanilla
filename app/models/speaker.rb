class Speaker
  include Mongoid::Document

  attr_accessible :user, :discussion

  belongs_to :user
  embedded_in :discussion
end
