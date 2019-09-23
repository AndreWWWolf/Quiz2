class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to ideas_path, notice: "Signed In!"
        else
            render :new, alert: "Try again!"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to ideas_path, notice: "Signed Out!"
    end

    private
end
