##
# All CRUD and search operations for score types are handled in this controller

class Api::V1::ScoreTypesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :score_types, "Score Types"

  swagger_api :index do
    summary "Searches for Score Types"
    param :query, :score_type_ids, :string, :optional, "score_type_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :score_types
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Score Type"
    param :path, :id, :integer, :required, "score_type_id"
    response :ok, "Success", :score_type
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Score Type"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    param :form, :points, :integer, :required, "points"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Score Type"
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
    summary "Deletes an existing Score Type"
    param :path, :id, :integer, :required, "score_type_id"
    response :unauthorized
    response :not_found
  end

  ##
  # Method for searching for a score type

  def index
    respond_with ScoreType.search(score_type_search_params)
  end

  ##
  # Method for showing one score type

  def show
    respond_with ScoreType.find(params[:id])
  end

  ##
  # Method for creating a score type

  def create
    score_type = ScoreType.new(score_type_params)
    if score_type.save
      render json: score_type, status: 201, location: [:api, score_type]
    else
      render json: { errors: score_type.errors }, status: 422
    end
  end

  ##
  # Method for updating a score type's details

  def update
    score_type = ScoreType.find(params[:id])
    if score_type.update(score_type_params)
      render json: score_type, status: 200, location: [:api, score_type]
    else
      render json: { errors: score_type.errors }, status: 422
    end
  end

  ##
  # Method for deleting a score type from the db

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
