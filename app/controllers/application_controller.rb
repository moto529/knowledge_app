class ApplicationController < ActionController::Base
  before_action :config_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    timeline_knowledges_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  private

  def config_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name birth_date email])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name birth_date email])
  end
end
