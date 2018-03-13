class User::RegistrationsController < Devise::RegistrationsController
  before_action :confiure_permitted_parameters

  def confiure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :second_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :second_name])
  end
end
