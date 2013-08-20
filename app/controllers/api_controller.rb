class ApiController < ApplicationController
  before_filter :authenticate_user!
  after_filter :user_activity

  self.responder = ActsAsApi::Responder

  respond_to :json, :xml

  private
  def user_activity
    current_user.try(:touch, :last_response_at)
  end
end
