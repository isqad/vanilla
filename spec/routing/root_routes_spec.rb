require 'spec_helper'

describe 'Root routes' do

  let(:subject) { { :get => '/' } }

  before(:each) do
    FactoryGirl.create(:user, :email => 'test@example.com' )
    activate_authlogic
  end

  context 'by default' do
    it { should route_to(:controller => 'user_sessions', :action => 'new') }
  end

  context 'when user logged in' do
    before do
      UserSession.create!(:email => 'test@example.com', :password => 'qwerty')
    end

    it { should route_to(:controller => 'pages', :action => 'home') }
  end
end