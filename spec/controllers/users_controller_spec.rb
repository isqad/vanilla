require 'spec_helper'

describe UsersController do

  let!(:subject) { response }

  describe 'GET new' do
    it { should be_success }
  end
end
