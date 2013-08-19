# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null
#  friend_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(255)      default("pending")
#

require 'spec_helper'

describe Friendship do

  let!(:friendship) { FactoryGirl.create(:friendship) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:user) }

  it 'pending by default' do
    friendship.should be_pending
  end

  it 'accept state if accepted' do
    friendship.accept!
    friendship.should be_friends
  end

  it 'destroyed if rejected' do
    friendship.reject!
    friendship.should be_subscriber
  end

  it 'allow to add friend through friends' do
    expect {
      user.friends << friend
    }.to change{user.friends.count}.by(1)
  end

  describe 'validation' do

    it 'uniqueness' do
      user.friendships.build(:friend_id => friend.id).save!
      user.friendships.build(:friend_id => friend.id).should_not be_valid
    end

    it 'reject self-friend' do
      user.friendships.build(:friend_id => user.id).should_not be_valid
    end
  end
end
