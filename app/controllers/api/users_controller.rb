class Api::UsersController < ApiController

  # GET /api/users/:id
  def show
    @user = User.find(params[:id])
    respond_with @user, :api_template => :user
  end

end
