##
# All CRUD and search operations for Roles are handled in this controller

class Api::V1::RolesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :roles, "Roles"

  # :nocov:
  swagger_api :index do
    summary "Searches for a Role"
    param :query, :role_ids, :string, :optional, "role_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :roles
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Role"
    param :path, :id, :integer, :required, "role_id"
    response :ok, "Success", :role
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Role"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Role"
    param :path, :id, :integer, :required, "role_id"
    param :form, :title, :string, :optional, "title"
    param :form, :url, :string, :optional, "url"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Role"
    param :path, :id, :integer, :required, "role_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a Role

  def index
    respond_with Role.search(role_search_params)
  end

  ##
  # Method for showing one Role

  def show
    respond_with Role.find(params[:id])
  end

  ##
  # Method for creating a Role

  def create
    role = Role.new(role_params)
    if role.save
      render json: role, status: 201, location: [:api, role]
    else
      failed_to_create(role, "role")
    end
  end

  ##
  # Method for updating a Role's details

  def update
    role = Role.find(params[:id])
    if role.update(role_params)
      render json: role, status: 200, location: [:api, role]
    else
      failed_to_update(role, "role")
    end
  end

  ##
  # Method for deleting a Role from the db

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

  ##
  # Strong params used when searching for Roles

  def role_search_params
    params.permit(:role_ids, :keyword)
  end

end
