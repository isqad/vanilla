class Api::UsersController < ApiController

  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user.friend = @user.friend_status_of(current_user)
    respond_with @user, api_template: :user
  end

end