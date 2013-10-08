# == Schema Information
#
# Table name: speakers
#
#  id            :integer          not null, primary key
#  discussion_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Speaker < ActiveRecord::Base

  attr_accessible :user, :discussion

  belongs_to :user
  belongs_to :discussion

  validates :user, :discussion, :presence => true
end
