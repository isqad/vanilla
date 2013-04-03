class Api::SearchController < ApiController

  before_filter :authenticate_user!

  def show
    query = params[:q]

    criteria = Regexp.new(".*#{query}.*", true)

    @users = User.where(:id.ne => current_user.id).any_of({
      'profile.first_name' => criteria
    }, {
      'profile.last_name' => criteria
    }, {
      'nickname' => criteria
    })

    @users.map do |u|
      u.friend = u.friend_status_of(current_user)
      u
    end

    respond_with @users, api_template: :user
  end

end