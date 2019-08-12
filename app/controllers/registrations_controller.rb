class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end