class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: @user.as_api_response(:as_user).to_json }
    end
  end

end