require 'spec_helper'

describe Friendship do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:user) }

  it 'should create a new instance given valid parameters' do
    expect {
      user.friendships.create!(friend: friend)
    }.to change{user.friendships.size}.by(1)
  end

  it 'pending by default' do
    user.friendships.create!(friend: friend)
    user.friendships[0].should be_pending
  end

  it 'should be unique' do
    user.friendships.create!(friend: friend)

    expect {
      user.friendships.create!(friend: friend)
    }.to_not change{user.friendships.size}.by(1)

  end
end