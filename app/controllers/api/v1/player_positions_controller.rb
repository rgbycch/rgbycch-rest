##
# All CRUD and search operations for PlayerPositions are handled in this controller

class Api::V1::PlayerPositionsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :player_positions, "PlayerPositions"

  # :nocov:
  swagger_api :index do
    summary "Searches for a PlayerPosition"
    param :query, :player_position_ids, :string, :optional, "player_position_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :player_positions
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a PlayerPosition"
    param :path, :id, :integer, :required, "player_position_id"
    response :ok, "Success", :player_position
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new PlayerPosition"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    param :form, :position_number, :integer, :required, "position_number"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing PlayerPosition"
    param :path, :id, :integer, :required, "player_position_id"
    param :form, :title, :string, :optional, "title"
    param :form, :url, :string, :optional, "url"
    param :form, :position_number, :integer, :optional, "position_number"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing PlayerPosition"
    param :path, :id, :integer, :required, "player_position_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a PlayerPosition

  def index
    respond_with PlayerPosition.search(player_position_search_params)
  end

  ##
  # Method for showing one PlayerPosition

  def show
    respond_with PlayerPosition.find(params[:id])
  end

  ##
  # Method for creating a PlayerPosition

  def create
    player_position = PlayerPosition.new(player_position_params)
    if player_position.save
      render json: player_position, status: 201, location: [:api, player_position]
    else
      failed_to_create(player_position, "player_position")
    end
  end

  ##
  # Method for updating a PlayerPosition details

  def update
    player_position = PlayerPosition.find(params[:id])
    if player_position.update(player_position_params)
      render json: player_position, status: 200, location: [:api, player_position]
    else
      failed_to_update(player_position, "player_position")
    end
  end

  ##
  # Method for deleting a PlayerPosition from the db

  def destroy
    player_position = PlayerPosition.find(params[:id])
    player_position.destroy
    head 204
  end

  private

  ##
  # Strong params for the PlayerPosition class.

  def player_position_params
    params.require(:player_position).permit(:title, :url, :position_number)
  end

  ##
  # Strong params used when searching for PlayerPositions.

  def player_position_search_params
    params.permit(:player_position_ids, :keyword)
  end

end
