require 'spec_helper'

describe UserSessionsController do
  let!(:user) { FactoryGirl.create(:user, :email => 'test@example.com' ) }
  let!(:subject) { response }

  describe 'GET new' do

    context 'by default' do
      before { get :new }

      it { should be_success }
    end

    context 'when user already logged in' do
      before do
        activate_authlogic
        UserSession.create!(:email => 'test@example.com', :password => 'qwerty')
        get :new
      end

      it { should redirect_to(authenticated_root_url) }
    end

  end

  describe 'POST create' do

    before(:each) do
      post :create, :user_session => { :email => 'test@example.com', :password => 'qwerty' }
    end

    it { should redirect_to(authenticated_root_url) }

    it 'create a new user session' do
      user_session = UserSession.find

      user_session.should be_present

      user_session.record.should be_eql(user)
    end
  end

  describe 'DELETE destroy' do

    before(:each) do
      activate_authlogic
    end

    context 'by default' do
      before do
        UserSession.create!(:email => 'test@example.com', :password => 'qwerty')
        delete :destroy
      end

      it { should redirect_to(root_url) }

      it 'destroy current session' do
        UserSession.find.should be_nil
      end
    end

    context 'when user not authenticated' do
      before do
        delete :destroy
      end

      it { should redirect_to(new_user_session_url) }
    end
  end
end
