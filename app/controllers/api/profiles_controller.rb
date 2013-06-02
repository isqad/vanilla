class Api::ProfilesController < ApiController

  def show
    respond_with current_user, api_template: :angular
  end

  def update
    current_user.update_attributes!(params[:profile].except(:id, :email, :avatar))

    respond_with current_user, api_template: :angular
  end

end
