class Api::FriendshipsController < ApiController

  # Friend list
  def show
    @friends = current_user.friendships.map{ |r| r.friend }

    respond_with @friends, api_template: :user
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

    case params[:status]
      when 'approve'
        if @friendship.update_attributes(status: Friendship.status[:friend])
          respond_with @friendship, location: nil
        else
          render nothing: true, status: 422
        end
      when 'cancel'
        @friendship.destroy
        render nothing: true
      else
        render nothing: true, status: 422
    end
  end

  # Destroy friendship
  def destroy
  end

end
