##
# All CRUD and search operations for ScoreTypes are handled in this controller

class Api::V1::ScoreTypesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :score_types, "ScoreTypes"

  # :nocov:
  swagger_api :index do
    summary "Searches for ScoreTypes"
    param :query, :score_type_ids, :string, :optional, "score_type_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :score_types
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a ScoreType"
    param :path, :id, :integer, :required, "score_type_id"
    response :ok, "Success", :score_type
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new ScoreType"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    param :form, :points, :integer, :required, "points"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing ScoreType"
    param :path, :id, :integer, :required, "score_type_id"
    param :form, :title, :string, :optional, "title"
    param :form, :url, :string, :optional, "url"
    param :form, :points, :integer, :optional, "points"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing ScoreType"
    param :path, :id, :integer, :required, "score_type_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a ScoreType

  def index
    respond_with ScoreType.search(score_type_search_params)
  end

  ##
  # Method for showing one ScoreType

  def show
    respond_with ScoreType.find(params[:id])
  end

  ##
  # Method for creating a ScoreType

  def create
    score_type = ScoreType.new(score_type_params)
    if score_type.save
      render json: score_type, status: 201, location: [:api, score_type]
    else
      failed_to_create(score_type, "score_type")
    end
  end

  ##
  # Method for updating a ScoreType's details

  def update
    score_type = ScoreType.find(params[:id])
    if score_type.update(score_type_params)
      render json: score_type, status: 200, location: [:api, score_type]
    else
      failed_to_update(score_type, "score_type")
    end
  end

  ##
  # Method for deleting a ScoreType from the db

  def destroy
    score_type = ScoreType.find(params[:id])
    score_type.destroy
    head 204
  end

  private

  ##
  # Strong params for the ScoreType class.

  def score_type_params
    params.require(:score_type).permit(:title, :url, :points)
  end

  ##
  # Strong params used when searching for ScoreTypes

  def score_type_search_params
    params.permit(:score_type_ids, :keyword)
  end

end
