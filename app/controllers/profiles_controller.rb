class ProfilesController < ApplicationController

  before_filter :authenticate_user!

  def show
    respond_to do |format|
      format.json { render json: current_user.as_api_response(:angular).to_json }
    end
  end

  def update
    current_user.update_attributes!(params[:profile].except(:id, :email, :avatar))

    respond_to do |format|
      format.json { render json: current_user.as_api_response(:angular).to_json, status: 200 }
    end

  end

end