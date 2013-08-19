class Api::ProfilesController < ApiController

  # GET /api/profile
  def show
    respond_with current_user, :api_template => :angular
  end

  # PUT /api/profile
  def update
    current_user.profile.update_attributes!(params[:profile].except(:id, :email, :avatar, :fullname, :username))

    respond_with current_user, :api_template => :angular
  end

end
