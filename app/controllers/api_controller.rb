class ApiController < ApplicationController
  before_filter :authenticate_user!

  self.responder = ActsAsApi::Responder

  respond_to :json, :xml
end
