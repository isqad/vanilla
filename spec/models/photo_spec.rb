# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_meta         :text
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

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
