##
# All CRUD and search operations for player positions are handled in this controller

class Api::V1::PlayerPositionsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :player_positions, "Player Positions"

  swagger_api :index do
    summary "Searches for a Player Position"
    param :query, :player_position_ids, :string, :optional, "player_position_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :player_positions
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Player Position"
    param :path, :id, :integer, :required, "player_position_id"
    response :ok, "Success", :player_position
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Player Position"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    param :form, :position_number, :integer, :required, "position_number"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Player Position"
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
    summary "Deletes an existing Player Position"
    param :path, :id, :integer, :required, "player_position_id"
    response :unauthorized
    response :not_found
  end

  ##
  # Method for searching for an player position

  def index
    respond_with PlayerPosition.search(player_position_search_params)
  end

  ##
  # Method for showing one player position

  def show
    respond_with PlayerPosition.find(params[:id])
  end

  ##
  # Method for creating a player position

  def create
    player_position = PlayerPosition.new(player_position_params)
    if player_position.save
      render json: player_position, status: 201, location: [:api, player_position]
    else
      render json: { errors: player_position.errors }, status: 422
    end
  end

  ##
  # Method for updating a player position details

  def update
    player_position = PlayerPosition.find(params[:id])
    if player_position.update(player_position_params)
      render json: player_position, status: 200, location: [:api, player_position]
    else
      render json: { errors: player_position.errors }, status: 422
    end
  end

  ##
  # Method for deleting a player position from the db

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
  # Strong params used when searching for Player Positions.

  def player_position_search_params
    params.permit(:player_position_ids, :keyword)
  end

end
