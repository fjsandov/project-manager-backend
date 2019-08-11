class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    render json: {
      success: true,
      userId: resource.id,
      jwtToken: current_token
    }
  end

  def respond_with(resource, _opts = {})
    render json: resource
  end

  private

  def respond_to_on_destroy
    head :no_content
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end