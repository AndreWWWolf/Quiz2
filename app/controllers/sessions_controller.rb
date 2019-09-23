class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to ideas_path, notice: "We Are In!"
        else
            render :new, alert: "That didn't work! Try something else."
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to ideas_path, notice: "We Are Out!"
    end

    private
end
