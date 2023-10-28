class Api::SessionsController < ApplicationController
  def login(user)
    session[:user_id] = user.id
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # debugger
    if user && user.authenticate(params[:session][:password])

      # remember_me boolean check_box from frontend
      params[:remember_me] ? remember(user) : forget(user)
      # remember user
      # User is logged in
      session[:user_id] = user.id
      render json: user, status: :ok
    else
      render json: { error: "User not Found!" }, status: :unprocessable_entity
    end
    # debugger
  end

  # remember in persistent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # log out
  def destroy
    forget(current_user)
    reset_session # session.delete :user_id
    # debugger
    head :no_content
  end

  # forgets a persisten session
  def forget(user)
    # debugger
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
