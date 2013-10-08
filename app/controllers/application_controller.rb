class ApplicationController < ActionController::Base
  include Concerns::AuthlogicConcern

  protect_from_forgery

  helper_method :current_user
end
