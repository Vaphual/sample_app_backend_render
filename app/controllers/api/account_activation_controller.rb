class Api::AccountActivationController < ApplicationController

    def edit 
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            # user.update_attribute(:activated, true)
            # user.update_attribute(:activated_at, Time.zone.now)
            user.activate
            session[:user_id] = user.id 
            render json: [ { message: "Account Activated!"}, {user: user}], status: :ok 
        else 
            render json: { message: " Invalid activation link"}, status: :unprocessable_entity
        end

    end
end
