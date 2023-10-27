class Api::UsersController < ApplicationController

  def index 
    if @current_user
      render json: @current_user, status: :ok 
    else 
      render json: { error: "Please log in!"}, status: :unauthorized
    end
  end

  def show
    render json: { message: "Hello World!"}
  end

  def create 
    @user = User.create(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
