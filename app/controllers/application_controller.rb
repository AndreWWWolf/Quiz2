class ApplicationController < ActionController::Base
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate!
        redirect_to new_session_path, alert: "Whoa! We gotta know who you are before you can get all fancy. Sign in first!" unless user_signed_in?
    end
end
