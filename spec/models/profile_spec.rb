require 'spec_helper'

describe Profile do

  let!(:attrs) {
    {
      first_name: 'Andrew',
      last_name: 'Hunter',
      birthday: 24.years.ago.to_date,
      bio: 'I am cat lover',
      gender: 'male'
    }
  }

  describe 'length first_name must be in 3..15 but not required' do
    it 'length greater than 3' do
      Profile.new(attrs.merge(first_name: 'a'*2)).should_not be_valid
    end

    it 'length less than 15' do
      Profile.new(attrs.merge(first_name: 'a'*16)).should_not be_valid
    end

    it 'not required' do
      Profile.new(attrs.merge(first_name: '')).should be_valid
    end
  end

end
