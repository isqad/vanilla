class Api::PostsController < ApiController

  before_filter :authenticate_user!, :find_user

  def index
    @posts = @user.posts
    respond_with @posts, api_template: :angular
  end

  def create
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

end