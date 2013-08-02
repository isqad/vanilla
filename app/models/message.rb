class Message < ActiveRecord::Base

  attr_accessible :body, :discussion, :user

  belongs_to :discussion
  belongs_to :user
end
