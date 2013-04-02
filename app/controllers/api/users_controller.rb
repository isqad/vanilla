class Api::UsersController < ApiController

  def show
    @user = User.find(params[:id])
    respond_with @user, api_template: :user
  end

end