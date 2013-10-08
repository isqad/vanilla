require 'spec_helper'

describe Api::FriendshipsController do

  let!(:user) { FactoryGirl.create(:user, :email => 'test@example.com' ) }

  before(:each) do
    activate_authlogic
    UserSession.create!(:email => 'test@example.com', :password => 'qwerty')
  end

  describe 'PUT update' do
    let!(:friendship) { FactoryGirl.create(:friendship, :owner => user) }

    it 'raises 400 Bad request when state params is not accept or reject' do

      put :update, :user_id => friendship.friend_id, :id => friendship.id, :state => 'test', :format => :json

      # Bad request
      response.status.should == 400
    end
  end

  describe 'POST create' do

    let!(:friend) { FactoryGirl.create(:user, :email => 'test2@example.com') }

    it 'success' do
      post :create, :user_id => friend.id, :format => :json

      response.should be_success
    end

    it 'raises 422 Unprocessible entity when create with errors' do
      post :create, :user_id => subject.current_user.id, :format => :json

      response.status.should == 422
    end
  end
end
