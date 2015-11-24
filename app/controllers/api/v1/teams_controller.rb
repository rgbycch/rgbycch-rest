##
# All CRUD and search operations for teams are handled in this controller

class Api::V1::TeamsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :teams, "Teams"

  # :nocov:
  swagger_api :index do
    summary "Searches for a Team"
    param :query, :team_ids, :string, :optional, "team_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :teams
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Team"
    param :path, :id, :integer, :required, "team_id"
    response :ok, "Success", :team
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Team"
    param :form, :title, :string, :required, "title"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Team"
    param :path, :id, :integer, :required, "team_id"
    param :form, :title, :string, :required, "title"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :add_player do
    summary "Adds a player to an existing Team"
    param :path, :team_id, :integer, :required, "team_id"
    param :form, :id, :string, :required, "the player id"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :remove_player do
    summary "Removes a player from an existing Team"
    param :path, :team_id, :integer, :required, "team_id"
    param :form, :id, :string, :required, "the player id"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Team"
    param :path, :id, :integer, :required, "team_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a score type

  def index
    respond_with Team.search(team_search_params)
  end

  ##
  # Method for showing one team

  def show
    respond_with Team.find(params[:id])
  end

  ##
  # Method for creating a team

  def create
    team = Team.new(team_params)
    if team.save
      render json: team, status: 201, location: [:api, team]
    else
      failed_to_create(team, "team")
    end
  end

  ##
  # Method for updating a team's details

  def update
    team = Team.find(params[:id])
    if team.update(team_params)
      render json: team, status: 200, location: [:api, team]
    else
      failed_to_update(team, "team")
    end
  end

  ##
  # Adding a player to a team

  def add_player
    team = Team.find(params[:team_id])
    player = Player.find(params[:id])
    team.players << player
    update_team(team)
  end

  ##
  # Removing a player from a team

  def remove_player
    team = Team.find(params[:team_id])
    player = Player.find(params[:id])
    team.players.delete(player)
    update_team(team)
  end

  ##
  # Method for deleting a team from the db

  def destroy
    team = Team.find(params[:id])
    team.destroy
    head 204
  end

  private

  ##
  # Common functionality for updating a team

  def update_team(team)
    if team.save
      render json: team, status: 200, location: [:api, team]
    else
      failed_to_update(team, "team")
    end
  end

  ##
  # Strong params for the Team class.

  def team_params
    params.require(:team).permit(:title)
  end

  ##
  # Strong params used when searching for Teams

  def team_search_params
    params.permit(:team_ids, :keyword)
  end

end
