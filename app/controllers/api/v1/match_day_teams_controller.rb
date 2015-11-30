##
# All CRUD and search operations for match-day teams are handled in this controller

class Api::V1::MatchDayTeamsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :match_day_teams, "Match-Day Teams"

  # :nocov:
  swagger_api :index do
    summary "Searches for a Match-Day Team"
    param :query, :match_day_team_ids, :string, :optional, "match_day_team_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :match_day_teams
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Match-Day Team"
    param :path, :id, :integer, :required, "match_day_team_id"
    response :ok, "Success", :team
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Match-Day Team"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Match-Day Team"
    param :path, :id, :integer, :required, "match_day_team_id"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :add_match_day_player do
    summary "Adds a match-day player to an existing match-day Team"
    param :path, :match_day_team_id, :integer, :required, "match_day_team_id"
    param :form, :id, :string, :required, "the player id"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :remove_player do
    summary "Removes an existing match-day player from a match-day Team"
    param :path, :match_day_team_id, :integer, :required, "match_day_team_id"
    param :form, :id, :string, :required, "the match-day player id"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Match-Day Team"
    param :path, :id, :integer, :required, "match_day_team_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a score type

  def index
    respond_with MatchDayTeam.search(team_search_params)
  end

  ##
  # Method for showing one Match-Day Team

  def show
    respond_with MatchDayTeam.find(params[:id])
  end

  ##
  # Method for creating a Match-Day Team

  def create
    match_day_team = MatchDayTeam.new(match_day_team_params)
    if match_day_team.save
      render json: match_day_team, status: 201, location: [:api, match_day_team]
    else
      failed_to_create(match_day_team, "match_day_team")
    end
  end

  ##
  # Method for updating a Match-Day Team's details

  def update
    match_day_team = MatchDayTeam.find(params[:id])
    if match_day_team.update(match_day_team_params)
      render json: match_day_team, status: 200, location: [:api, match_day_team]
    else
      failed_to_update(match_day_team, "match_day_team")
    end
  end

  ##
  # Adding a match-day player to a match-day team

  def add_match_day_player
    match_day_team = MatchDayTeam.find(params[:match_day_team_id])
    match_day_player = MatchDayPlayer.find(params[:id])
    match_day_team.match_day_players << match_day_player
    update_match_day_team(match_day_team)
  end

  ##
  # Removing a match-day player from a match-day team

  def remove_match_day_player
    match_day_team = MatchDayTeam.find(params[:match_day_team_id])
    match_day_player = MatchDayPlayer.find(params[:id])
    match_day_team.match_day_players.delete(match_day_player)
    update_match_day_team(match_day_team)
  end

  ##
  # Method for deleting a Match-Day Team from the db

  def destroy
    match_day_team = MatchDayTeam.find(params[:id])
    match_day_team.destroy
    head 204
  end

  private

  ##
  # Common functionality for updating a match-day team

  def update_match_day_team(match_day_team)
    if match_day_team.save
      render json: match_day_team, status: 200, location: [:api, match_day_team]
    else
      failed_to_update(match_day_team, "match_day_team")
    end
  end

  ##
  # Strong params for the Match-Day Team class.

  def match_day_team_params
    params.require(:match_day_team).permit(:title, :url)
  end

  ##
  # Strong params used when searching for Match-Day Teams

  def team_search_params
    params.permit(:match_day_team_ids, :keyword)
  end

end
