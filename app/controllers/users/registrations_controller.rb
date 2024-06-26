# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully registartion',
          data: resource }
      }, status: :ok
    else
      render json: {
        status: { message: 'User could not be created successfull',
        errors: resource.errors.full_message }, status: :unprocessable_entity
      }
    end
end
end
