class RegistrationsController < Devise::RegistrationsController

  def new
    resource = build_resource({})
    respond_with resource, layout: 'auth'
  end

end
