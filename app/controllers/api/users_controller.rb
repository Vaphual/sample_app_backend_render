class Api::UsersController < ApplicationController

  def index 
    if current_user
      render json: current_user, status: :ok 
    else 
      render json: { error: "Please log in!"}, status: :unauthorized
    end
  end

  def show
    render json: { message: "Hello World!"}
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
      # send active account email 
      UserMailer.account_activation(@user).deliver_later 
      render json: { message: "check your email to activate your account "}, status: :ok 
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
