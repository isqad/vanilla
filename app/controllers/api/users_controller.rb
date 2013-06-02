class Api::UsersController < ApiController

  def show
    @user = User.find(params[:id])
    @user.friend = current_user.friend_status_of(@user)
    respond_with @user, api_template: :user
  end

end
