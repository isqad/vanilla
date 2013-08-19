class Api::ProfilesController < ApiController
  # GET /api/profile
  def show
    respond_with current_user, :api_template => :angular
  end

  # PUT /api/profile
  def update
    current_user.profile.update_attributes!(params[:profile].except(:id, :email, :avatar, :fullname, :username))

    render_for_api :angular, :json => current_user
  end

end
