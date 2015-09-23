##
# All CRUD operations for users are handled in this controller

class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:update, :destroy]

  swagger_controller :users, "Users"

  swagger_api :show do
    summary "Gets a User"
    param :path, :id, :integer, :required, "user_id"
    response :ok, "Success", :user
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new User"
    param :form, :email, :string, :required, "email"
    param :form, :password, :string, :required, "password"
    param :form, :password_confirmation, :string, :required, "password_confirmation"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing User"
    param :path, :id, :integer, :required, "user_id"
    param :form, :email, :string, :optional, "email"
    param :form, :password, :string, :optional, "password"
    param :form, :password_confirmation, :string, :optional, "password_confirmation"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing User"
    param :path, :id, :integer, :required, "user_id"
    response :unauthorized
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