class PasswordsController < ApplicationController
  before_filter :require_no_user
  before_filter :user_by_perishable_token, :only => [ :edit, :update ]

  layout 'auth'

  # POST /password
  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.deliver_password_instructions!
      flash[:notice] = I18n.t('users.passwords.send_instructions')
      redirect_to root_url
    else
      flash[:alert] = I18n.t('users.failure.invalid')
      render :new
    end
  end

  # PUT /password
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t('users.passwords.change_success')
      redirect_to root_url
    else
      render :edit
    end
  end

  private
  def user_by_perishable_token
    @user = User.find_using_perishable_token(params[:token])

    unless @user
      flash[:alert] = I18n.t('users.failure.invalid')
      redirect_to(root_url) and return false
    end
  end

end