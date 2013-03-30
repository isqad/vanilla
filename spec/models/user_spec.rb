require 'spec_helper'

describe User do
  let!(:attrs) {
    {
      nickname: "Andrew",
      email: "isqad88@ya.ru",
      password: "password123"
    }
  }

  it 'create a valid instance given valid parameters' do
    User.create!(attrs)
  end

  it 'require a email' do
    User.new(attrs.merge(email: '')).should_not be_valid
  end

  it 'require a nickname' do
    User.new(attrs.merge(nickname: '')).should_not be_valid
  end

  it 'length of nickname must be in 3..15' do
    User.new(attrs.merge(nickname: 'a'*5)).should be_valid
    User.new(attrs.merge(nickname: 'a'*16)).should_not be_valid
    User.new(attrs.merge(nickname: 'a'*2)).should_not be_valid
  end

  it 'reject duplicate email addresses' do
    User.create!(attrs)
    User.new(attrs).should_not be_valid
  end

  it 'reject email addresses identical up to case' do
    upcased_email = attrs[:email].upcase
    User.create!(attrs.merge(email: upcased_email))
    User.new(attrs).should_not be_valid
  end

end