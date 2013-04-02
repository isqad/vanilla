require 'spec_helper'

describe Photo do

  let!(:user) { FactoryGirl.create(:user) }

  let!(:attrs) {
    {
      image: File.open(Rails.root.join('spec', 'support', 'big_image.jpg')),
      user: user
    }
  }

  it 'should create a valid instance given valid attrs' do
    Photo.create!(attrs)
  end

  it 'required author' do
    Photo.new(attrs.merge(user: nil)).should_not be_valid
  end

  it 'reqired image' do
    Photo.new(attrs.merge(image: nil)).should_not be_valid
  end
end