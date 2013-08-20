# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe Post do

  let!(:user) { FactoryGirl.create(:user) }

  let!(:attrs) {
    {
      author: user,
      body: "Test post body"
    }
  }

  it 'required author' do
    Post.new(attrs.merge(author: nil)).should_not be_valid
  end

  it 'required body' do
    Post.new(attrs.merge(body: nil)).should_not be_valid
  end

  it 'required length body less than 6000' do
    Post.new(attrs.merge(body: 'a'*6001)).should_not be_valid
  end

end
