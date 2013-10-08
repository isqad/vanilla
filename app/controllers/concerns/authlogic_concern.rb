module Concerns
  module AuthlogicConcern
    extend ActiveSupport::Concern

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        redirect_to new_user_session_url, :alert => I18n.t('users.you_must_logged_in')
        false
      end
    end

    def require_no_user
      if current_user
        redirect_to root_url
        false
      end
    end

    private :current_user_session, :require_user, :require_no_user
  end
end