##
# All CRUD and search operations for PlayerStates are handled in this controller

class Api::V1::PlayerStatesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :player_states, "PlayerStates"

  # :nocov:
  swagger_api :index do
    summary "Searches for PlayerStates"
    param :query, :player_state_ids, :string, :optional, "player_state_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :player_states
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a PlayerState"
    param :path, :id, :integer, :required, "player_state_id"
    response :ok, "Success", :player_state
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new PlayerState"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing PlayerState"
    param :path, :id, :integer, :required, "player_state_id"
    param :form, :title, :string, :optional, "title"
    param :form, :url, :string, :optional, "url"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing PlayerState"
    param :path, :id, :integer, :required, "player_state_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a PlayerState

  def index
    respond_with PlayerState.search(player_state_search_params)
  end

  ##
  # Method for showing one PlayerState

  def show
    respond_with PlayerState.find(params[:id])
  end

  ##
  # Method for creating a PlayerState

  def create
    player_state = PlayerState.new(player_state_params)
    if player_state.save
      render json: player_state, status: 201, location: [:api, player_state]
    else
      failed_to_create(player_state, "player_state")
    end
  end

  ##
  # Method for updating a PlayerState's details

  def update
    player_state = PlayerState.find(params[:id])
    if player_state.update(player_state_params)
      render json: player_state, status: 200, location: [:api, player_state]
    else
      failed_to_update(player_state, "player_state")
    end
  end

  ##
  # Method for deleting a PlayerState from the db

  def destroy
    player_state = PlayerState.find(params[:id])
    player_state.destroy
    head 204
  end

  private

  ##
  # Strong params for the MatchState class.

  def player_state_params
    params.require(:player_state).permit(:title, :url)
  end

  ##
  # Strong params used when searching for PlayerStates

  def player_state_search_params
    params.permit(:player_state_ids, :keyword)
  end

end
