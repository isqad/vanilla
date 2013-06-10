class Static::TemplatesController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def show
    render 'static/' + params[:path]
  end
end
