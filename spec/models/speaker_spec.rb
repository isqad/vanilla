# == Schema Information
#
# Table name: speakers
#
#  id            :integer          not null, primary key
#  discussion_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Speaker do
  let!(:user) { FactoryGirl.build(:user) }

  it 'should not create without discussion' do
    speaker = Speaker.new(:user => user)
    speaker.save.should_not be true
  end
end
