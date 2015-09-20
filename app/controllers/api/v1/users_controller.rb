##
# All CRUD operations for users are handled in this controller

class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:update, :destroy]

  swagger_controller :users, "User Management"

  swagger_api :show do
    summary "Fetches a single User"
    param :path, :id, :integer, :optional, "User Id"
    response :ok, "Success", :User
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  ##
  # Method for showing one user

  def show
    respond_with User.find(params[:id])
  end

  ##
  # Method for creating a user

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  ##
  # Method for updating a user's details

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  ##
  # Method for deleting a user from the db

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

  ##
  # Strong params for the User class.

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end