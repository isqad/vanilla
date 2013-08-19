# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  body          :text
#  discussion_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Message < ActiveRecord::Base

  attr_accessible :body, :discussion, :user

  belongs_to :discussion
  belongs_to :user
end
