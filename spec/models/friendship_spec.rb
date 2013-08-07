# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null
#  friend_id  :integer          not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Friendship do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:user) }

  it 'should create a two new instances given valid parameters' do
    expect {
      user.friendships.create!(friend: friend)
    }.to change{Friendship.count}.by(2)
  end

  it 'pending by default for sender' do
    user.friendships.create!(friend: friend)
    user.friendships(true).first.status.should eql(Friendship.status[:pending])
  end

  it 'wating for receiver' do
    user.friendships.create!(friend: friend)
    friend.friendships(true).first.status.should eql(Friendship.status[:waiting])
  end

  it 'should be unique' do
    user.friendships.create!(friend: friend)

    user.friendships.build(friend: friend).should_not be_valid

  end

  it 'should reject given self' do
    user.friendships.build(friend: user).should_not be_valid
  end

  it 'should approve to both sides' do
    user.friendships.create!(friend: friend)

    friend.friendships(true).first.update_attributes!(status: Friendship.status[:friend])

    friend.friendships(true).first.status.should eql(Friendship.status[:friend])
    user.friendships(true).first.status.should eql(Friendship.status[:friend])
  end

  it 'should destroy to both sides' do
    user.friendships.create!(friend: friend)

    expect {
      friend.friendships(true).first.destroy
    }.to change{Friendship.count}.from(2).to(0)
  end
end
