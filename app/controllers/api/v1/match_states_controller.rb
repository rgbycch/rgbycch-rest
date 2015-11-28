##
# All CRUD and search operations for match states are handled in this controller

class Api::V1::MatchStatesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :match_states, "Match States"

  # :nocov:
  swagger_api :index do
    summary "Searches for Match States"
    param :query, :match_state_ids, :string, :optional, "match_state_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :match_states
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Match State"
    param :path, :id, :integer, :required, "match_state_id"
    response :ok, "Success", :match_state
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Match State"
    param :form, :title, :string, :required, "title"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Match State"
    param :path, :id, :integer, :required, "match_state_id"
    param :form, :title, :string, :required, "title"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Match State"
    param :path, :id, :integer, :required, "match_state_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a Match State

  def index
    respond_with MatchState.search(match_state_search_params)
  end

  ##
  # Method for showing one Match State

  def show
    respond_with MatchState.find(params[:id])
  end

  ##
  # Method for creating a Match State

  def create
    match_state = MatchState.new(match_state_params)
    if match_state.save
      render json: match_state, status: 201, location: [:api, match_state]
    else
      failed_to_create(match_state, "match_state")
    end
  end

  ##
  # Method for updating a Match State's details

  def update
    match_state = MatchState.find(params[:id])
    if match_state.update(match_state_params)
      render json: match_state, status: 200, location: [:api, match_state]
    else
      failed_to_update(match_state, "match_state")
    end
  end

  ##
  # Method for deleting a Match State from the db

  def destroy
    match_state = MatchState.find(params[:id])
    match_state.destroy
    head 204
  end

  private

  ##
  # Strong params for the MatchState class.

  def match_state_params
    params.require(:match_state).permit(:title)
  end

  ##
  # Strong params used when searching for MatchStates

  def match_state_search_params
    params.permit(:match_state_ids, :keyword)
  end

end
