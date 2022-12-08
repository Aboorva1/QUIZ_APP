class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:image])
      devise_parameter_sanitizer.permit(:account_update, keys: [:image])
    end

    def check_user
      if !current_user.is_admin?
        flash[:error] = "You don't have access" 
        redirect_back(fallback_location: root_path)
      end
    end

end
