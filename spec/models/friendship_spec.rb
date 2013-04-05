require 'spec_helper'

describe Friendship do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:user) }

  it 'should create a two new instances given valid parameters' do
    expect {
      user.friendships.create!(friend: friend)
    }.to change{user.friendships.size}.by(2)
  end

  it 'pending by default for sender' do
    user.friendships.create!(friend: friend)
    user.friendships(true)[0].status.should eql('pending')
  end

  it 'wating for receiver' do
    user.friendships.create!(friend: friend)
    friend.friendships(true)[0].status.should eql('waiting')
  end

  it 'should be unique' do
    user.friendships.create!(friend: friend)

    user.friendships.build(friend: friend).should_not be_valid

  end

  it 'should reject given self' do
    user.friendships.build(friend: user).should_not be_valid
  end
end