class Api::FriendshipsController < ApiController

  before_filter :find_user

  # POST /api/users/:user_id/friendships
  def create
    @friendship = current_user.friendships.build(:friend_id => @user.id)

    if @friendship.save
      respond_with @friendship, :location => nil
    else
      respond_with @friendship
    end
  end

  # PUT /api/users/:user_id/friendships/:id
  def update
    @friendship = current_user.friendships.find(params[:id])

    render(:nothing => true, :status => :bad_request) and return unless %w(reject accept).include? params[:state]

    @friendship.send("#{params[:state]}!".to_sym)

    respond_with @friendship, :location => nil
  end

  # DELETE /api/users/:user_id/friendships/:id
  def destroy
    @friendship = current_user.friendships.find(params[:id])

    @friendship.destroy

    respond_with @friendship, :location => nil
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

end
