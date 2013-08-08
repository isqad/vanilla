class Api::PostsController < ApiController

  before_filter :find_user

  def index
    @posts = @user.posts
    respond_with @posts, :api_template => :angular
  end

  # POST /api/users/:user_id/posts
  def create
    @post = Post.new(params[:post].except(:author_id).merge(:author => current_user))

    if @post.save
      respond_with @post, :api_template => :angular, :location => nil
    else
      respond_with @post.errors
    end
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

end
