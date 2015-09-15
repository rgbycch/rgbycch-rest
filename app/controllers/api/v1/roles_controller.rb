##
# All CRUD operations for roles are handled in this controller

class Api::V1::RolesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  ##
  # Method for showing one role

  def show
    respond_with Role.find(params[:id])
  end

  ##
  # Method for creating an role

  def create
    role = Role.new(role_params)
    if role.save
      render json: role, status: 201, location: [:api, role]
    else
      render json: { errors: role.errors }, status: 422
    end
  end

  ##
  # Method for updating an role's details

  def update

  end

  ##
  # Method for deleting an role from the db

  def destroy
    role = Role.find(params[:id])
    role.destroy
    head 204
  end

  private

  ##
  # Strong params for the Role class.

  def role_params
    params.require(:role).permit(:title, :url)
  end

end
