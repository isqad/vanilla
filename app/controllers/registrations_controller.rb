class RegistrationsController < ApplicationController
  before_filter :require_no_user

  layout 'auth'

  # GET /registration/new
  def new
    @user = User.new
  end

  # POST /registration
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

end