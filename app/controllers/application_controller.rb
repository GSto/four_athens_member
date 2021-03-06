class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name) }
    devise_parameter_sanitizer.for(:invite) { |u| u.permit(:first_name, :last_name) }
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
    # Override accepted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:first_name, :last_name, :password, :password_confirmation,
               :invitation_token)
    end
  end
end

