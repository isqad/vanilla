# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  notify     :text             not null
#  user_id    :integer
#  from_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Notification do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:user) }

  it 'should send notification to friend' do
    expect {
      user.friendships.create!(:friend_id => friend.id)
    }.to change{Notification.count}.by(1)
  end

end
