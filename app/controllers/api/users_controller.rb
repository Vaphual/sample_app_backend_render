class Api::UsersController < ApplicationController

  def show 
    render json: { message: "User create"}
  end

  def index
    render json: { message: "Hello World!"}
  end
end
