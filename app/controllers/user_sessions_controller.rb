class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [ :new, :create ]
  before_filter :require_user, :only => [ :destroy ]

  # GET /user_session/new
  def new
    @user_session = UserSession.new
  end

  # POST /user_session
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      redirect_to authenticated_root_url
    else
      render :new
    end
  end

  # DELETE /user_session
  def destroy
    current_user_session.destroy
    redirect_to root_url
  end

end