class Api::NotificationsController < ApiController

  def index
    @notifications = current_user.notifications

    respond_with @notifications, api_template: :angular
  end
end
