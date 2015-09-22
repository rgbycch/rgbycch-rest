##
# All CRUD operations for players are handled in this controller

class Api::V1::PlayersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  ##
  # Method for showing one player

  def show
    respond_with Player.find(params[:id])
  end

  ##
  # Method for creating a player

  def create
    player = Player.new(player_params)
    if player.save
      render json: player, status: 201, location: [:api, player]
    else
      render json: { errors: player.errors }, status: 422
    end
  end

  ##
  # Method for updating a player details

  def update
    player = Player.find(params[:id])
    if player.update(player_params)
      render json: player, status: 200, location: [:api, player]
    else
      render json: { errors: player.errors }, status: 422
    end
  end

  ##
  # Method for deleting a player from the db

  def destroy
    player = Player.find(params[:id])
    player.destroy
    head 204
  end

  private

  ##
  # Strong params for the Player class.

  def player_params
    params.require(:player).permit(:first_name, :last_name, :nick_name, :dob, :email, :phone_number)
  end
end
