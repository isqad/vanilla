class PasswordsController < ApplicationController
  before_filter :require_no_user, :only => [ :new, :create ]

  layout 'auth'

  # GET /password/new
  def new
    @user = User.new
  end

  # POST /password
  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.deliver_password_instructions!
      flash[:notice] = I18n.t('users.passwords.send.send_instructions')
      redirect_to root_url
    else
      flash[:alert] = I18n.t('users.failure.invalid')
      render :new
    end
  end

end