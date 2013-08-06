require 'spec_helper'

describe User do
  let!(:user) { FactoryGirl.build(:user) }

  it 'create a valid instance given valid parameters' do
    user.save!
  end

  it 'require a email' do
    FactoryGirl.build(:user, email: '').should_not be_valid
  end

  it 'require a username' do
    FactoryGirl.build(:user, username: '').should_not be_valid
  end

  it 'length of username must be in 3..15' do
    FactoryGirl.build(:user, username: 'a'*5).should be_valid
    FactoryGirl.build(:user, username: 'a'*16).should_not be_valid
    FactoryGirl.build(:user, username: 'a'*2).should_not be_valid
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

  it 'always has a profile' do
    User.new.profile.should_not be_nil
  end

end
