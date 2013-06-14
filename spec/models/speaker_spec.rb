require 'spec_helper'

describe Speaker do
  let!(:user) { FactoryGirl.build(:user) }

  it 'should not create without discussion' do
    speaker = Speaker.new(:user => user)
    speaker.save.should_not be true
  end
end
