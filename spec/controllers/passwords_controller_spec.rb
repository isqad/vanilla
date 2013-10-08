require 'spec_helper'

describe PasswordsController do
  let(:subject) { response }

  describe 'GET new' do
    before{ get :new }

    it { should be_success }
  end

  describe 'POST create' do
    let!(:user) { FactoryGirl.create(:user, :email => 'test@example.com' ) }

    before do
      post :create, :user => { :email => 'test@example.com' }
    end

    it { should redirect_to(root_url) }
  end

end
