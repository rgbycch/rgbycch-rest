##
# All CRUD operations for player positions are handled in this controller

class Api::V1::PlayerPositionsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  ##
  # Method for showing one event type

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
end
