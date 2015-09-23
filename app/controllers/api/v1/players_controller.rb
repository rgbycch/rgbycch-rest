##
# All CRUD and search operations for players are handled in this controller

class Api::V1::PlayersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :players, "Players"

  swagger_api :index do
    summary "Searches for a Player"
    param :query, :player_ids, :string, :optional, "player_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :players
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Player"
    param :path, :id, :integer, :required, "player_id"
    response :ok, "Success", :player
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Player"
    param :form, :first_name, :string, :required, "first_name"
    param :form, :last_name, :string, :required, "last_name"
    param :form, :nick_name, :string, :optional, "nick_name"
    param :form, :dob, :string, :optional, "dob"
    param :form, :email, :string, :optional, "email"
    param :form, :phone_number, :string, :optional, "phone_number"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Player"
    param :path, :id, :integer, :required, "player_id"
    param :form, :first_name, :string, :optional, "first_name"
    param :form, :last_name, :string, :optional, "last_name"
    param :form, :nick_name, :string, :optional, "nick_name"
    param :form, :dob, :string, :optional, "dob"
    param :form, :email, :string, :optional, "email"
    param :form, :phone_number, :string, :optional, "phone_number"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Player"
    param :path, :id, :integer, :required, "player_id"
    response :unauthorized
    response :not_found
  end

  ##
  # Method for searching for a player

  def index
    respond_with Player.search(player_search_params)
  end

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

  ##
  # Strong params used when searching for Players

  def player_search_params
    params.permit(:player_ids, :keyword)
  end

end
