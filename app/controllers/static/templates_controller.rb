class Static::TemplatesController < ApplicationController
  before_filter :require_user

  layout false

  def show
    render 'static/' + params[:path]
  end
end
