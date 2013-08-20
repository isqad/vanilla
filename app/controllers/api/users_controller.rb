class Api::UsersController < ApiController

  has_scope :online, :type => :boolean

  # GET /api/users
  def index
    @users = apply_scopes(User).without_me(current_user).includes(:profile).ordered

    respond_with @users, :api_template => :user
  end

  # GET /api/users/:id
  def show
    @user = User.find(params[:id])
    respond_with @user, :api_template => :user
  end

end
