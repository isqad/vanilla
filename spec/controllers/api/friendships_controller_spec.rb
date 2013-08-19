require 'spec_helper'

describe Api::FriendshipsController do
  login_user

  let!(:friendship) { FactoryGirl.create(:friendship, :owner => subject.current_user) }

  it 'have a current user' do
    subject.current_user.should_not be_nil
  end

  describe 'PUT update' do
    it 'raises 400 Bad request when state params is not accept or reject' do

      put :update, :user_id => friendship.friend.id, :id => friendship.id, :state => 'test'

      # Bad request
      expect(response.status).to eq(400)
    end
  end

  describe 'POST create' do
    it 'raises 422 Unprocessible entity when create with errors' do
      post :create, :user_id => subject.current_user.id

      expect(response.status).to eq(422)
    end
  end
end
