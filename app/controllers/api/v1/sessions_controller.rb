##
# All CRUD operations for sessions are handled in this controller

class Api::V1::SessionsController < ApplicationController

  ##
  # Method for creating a new session and saving it to the current user

  def create

    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  ##
  # Method for destroying the current session. Similar to a logout operation.

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

end
