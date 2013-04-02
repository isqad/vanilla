class Api::ProfilesController < ApiController

  before_filter :authenticate_user!

  def show
    respond_with current_user, api_template: :angular
  end

  def update
    current_user.update_attributes!(params[:profile].except(:id, :email, :avatar))
    respond_with current_user, api_template: :angular
  end

end