require 'spec_helper'

describe User do
  let!(:user) { FactoryGirl.build(:user) }

  let!(:attrs) {
    {
      nickname: 'isqad88',
      first_name: 'Andrew',
      last_name: 'Hunter',
      bio: 'I am cat lover',
      birthday: 24.years.ago.to_date,
      gender: 'male'
    }
  }

  it 'create a valid instance given valid parameters' do
    user.save!
  end

  it 'require a email' do
    FactoryGirl.build(:user, email: '').should_not be_valid
  end

  it 'require a nickname' do
    FactoryGirl.build(:user, nickname: '').should_not be_valid
  end

  it 'length of nickname must be in 3..15' do
    FactoryGirl.build(:user, nickname: 'a'*5).should be_valid
    FactoryGirl.build(:user, nickname: 'a'*16).should_not be_valid
    FactoryGirl.build(:user, nickname: 'a'*2).should_not be_valid
  end

  it 'reject duplicate email addresses' do
    user.save!
    FactoryGirl.build(:user, email: user.email).should_not be_valid
  end

  it 'reject email addresses identical up to case' do
    upcased_email = user.email.upcase
    FactoryGirl.create(:user, email: upcased_email)
    FactoryGirl.build(:user, email: upcased_email).should_not be_valid
  end

  it 'should has a profile' do
    User.new.profile.should_not be_nil
  end

  it 'allows directly assign profile attributes' do
    user.save!
    user.update_attributes!(attrs)

    user.first_name.should eql(attrs[:first_name])
    user.last_name.should eql(attrs[:last_name])
    user.bio.should eql(attrs[:bio])
    user.birthday.should eql(attrs[:birthday])
    user.gender.should eql(attrs[:gender])

    user.nickname.should eql(attrs[:nickname])
  end

  describe '.friend_status_of' do

    let!(:friend) { FactoryGirl.create(:user) }
    before(:each) { user.save! }

    it 'should return pending if in pending friend list' do
      user.friendships.create!(friend: friend)

      user.friend_status_of(friend).should eql(Friendship.status[:pending])
    end

    it 'should return false if not friend list' do
      user.friend_status_of(friend).should eql(false)
    end

    it 'should return friend if in friend list' do
      user.friendships.create!(friend: friend, status: Friendship.status[:friend])
      user.friend_status_of(friend).should eql(Friendship.status[:friend])
    end
   end

end