class Api::FriendshipsController < ApiController

  before_filter :authenticate_user!

  # Friend list
  def show
  end

  # Create friendship
  def create
    @user = User.find(params[:user_id])
    @friendship = current_user.friendships.build(friend: @user)

    if @friendship.save
      respond_with @friendship, location: nil
    else
      render nothing: true, status: 422
    end
  end

  # Update friend status
  def update
    @user = User.find(params[:user_id])
    @friendship = current_user.friendships.where(friend: @user).first

    render(nothing: true, status: 422) unless @friendship

    if params[:status] == 'approve'
      if @friendship.update_attributes(status: 'friend')
        respond_with @friendship, location: nil
      else
        render nothing: true, status: 422
      end
    elsif params[:status] == 'cancel'
      @friendship.destroy
      render nothing: true, status: 422
    end

  end

  # Destroy friendship
  def destroy
  end

end