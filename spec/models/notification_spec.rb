require 'spec_helper'

describe Notification do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:user) }

  it 'should send notification to friend' do
    expect {
      user.friendships.create!(friend: friend)
    }.to change{Notification.count}.by(1)
  end

end
