class Api::PostsController < ApiController

  before_filter :find_user

  # GET /api/users/:user_id/posts
  def index
    @posts = @user.posts
    respond_with @posts, :api_template => :angular
  end

  # POST /api/users/:user_id/posts
  def create

    @post = @user.posts.build(params[:post].merge(:author => current_user))

    if @post.save
      respond_with @post, :api_template => :angular, :location => nil
    else
      respond_with @post.errors
    end
  end

  # DELETE /api/users/:user_id/posts/:id
  def destroy
    @post = @user.posts.find(params[:id])

    @post.destroy

    respond_with @post, :api_template => :angular, :location => nil
  end

  # PUT /api/users/:user_id/posts/:id/recover
  def recover
    @post = @user.posts.with_deleted.find(params[:id])

    @post.recover

    respond_with @post, :api_template => :angular, :location => nil
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

end
