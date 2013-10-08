require 'spec_helper'

describe Static::TemplatesController do

  let!(:user) { FactoryGirl.create(:user, :email => 'test@example.com' ) }

  before(:each) do
    activate_authlogic
    UserSession.create!(:email => 'test@example.com', :password => 'qwerty')
  end

  describe 'GET show' do
    it 'success' do
      get :show, :path => '/home/index'

      response.should be_success
    end
  end
end
