class Api::SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:email].downcase)
    # debugger
    if user && user.authenticate(params[:password])
      # User is logged in
      session[:user_id] = user.id
      render json: user, status: :ok
    else 
      render json: {error: "User not Found!"}, status: :unprocessable_entity
    end
    # debugger
  end

  def destroy
    session.delete :user_id 
    head :no_content
  end
end
