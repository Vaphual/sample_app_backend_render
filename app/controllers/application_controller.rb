class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  private

  # return the user corresponding to the remember token cookie
  def current_user
    # debugger
    if (user_id = session[:user_id])
      #   debugger
      return @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
    #   debugger
      user = User.find_by(id: user_id)
      #   debugger
      if user && user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        return @current_user = user
      end
    else
      return nil
    end
  end
end
