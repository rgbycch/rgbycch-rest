##
# All CRUD and search operations for officials are handled in this controller

class Api::V1::OfficialsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :officials, "Officials"

  # :nocov:
  swagger_api :index do
    summary "Searches for Officials"
    param :query, :official_ids, :string, :optional, "official_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :officials
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets an Official"
    param :path, :id, :integer, :required, "official_id"
    response :ok, "Success",  :official
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Official"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Official"
    param :path, :id, :integer, :required, "official_id"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Official"
    param :path, :id, :integer, :required, "official_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for an Official

  def index
    respond_with Official.search(official_search_params)
  end

  ##
  # Method for showing one Official

  def show
    respond_with Official.find(params[:id])
  end

  ##
  # Method for creating an Official

  def create
    official = Official.new(official_params)
    if official.save
      render json: official, status: 201, location: [:api, official]
    else
      failed_to_create(official, "official")
    end
  end

  ##
  # Method for updating an Official's details

  def update
    official = Official.find(params[:id])
    if official.update(official_params)
      render json: official, status: 200, location: [:api, official]
    else
      failed_to_update(official, "official")
    end
  end

  ##
  # Method for deleting an Official from the db

  def destroy
    official = Official.find(params[:id])
    official.destroy
    head 204
  end

  private

  ##
  # Strong params for the Official class.

  def official_params
    params.require(:official).permit(:title, :url)
  end

  ##
  # Strong params used when searching for Officials

  def official_search_params
    params.permit(:official_ids, :keyword)
  end

end
