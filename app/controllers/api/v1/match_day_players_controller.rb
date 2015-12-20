##
# All CRUD and search operations for MatchDayPlayers are handled in this controller

class Api::V1::MatchDayPlayersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :match_day_players, "MatchDayPlayers"

  # :nocov:
  swagger_api :index do
    summary "Searches for a MatchDayPlayer"
    param :query, :match_day_player_ids, :string, :optional, "player_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :match_day_players
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a MatchDayPlayer"
    param :path, :id, :integer, :required, "match_day_player_id"
    response :ok, "Success", :match_day_player
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new MatchDayPlayer"
    param :form, :match_day_team_id, :integer, :required, "match_day_team_id"
    param :form, :player_id, :integer, :required, "player_id"
    param :form, :player_position_id, :integer, :required, "player_position_id"
    param :form, :rating, :integer, :optional, "rating"
    param :form, :points, :integer, :optional, "points"
    param :form, :fouls, :integer, :optional, "fouls"
    param :form, :turnovers_for, :integer, :optional, "turnovers_for"
    param :form, :turnovers_against, :integer, :optional, "turnovers_against"
    param :form, :penalties_won, :integer, :optional, "penalties_won"
    param :form, :penalties_conceded, :integer, :optional, "penalties_conceded"
    param :form, :yellow_cards, :integer, :optional, "yellow_cards"
    param :form, :red_cards, :integer, :optional, "red_cards"
    param :form, :carries, :integer, :optional, "carries"
    param :form, :yards_carried, :integer, :optional, "yards_carried"
    param :form, :forward_passes, :integer, :optional, "forward_passes"
    param :form, :successful_lineout_throws, :integer, :optional, "successful_lineout_throws"
    param :form, :unsuccessful_lineout_throws, :integer, :optional, "unsuccessful_lineout_throws"
    param :form, :scrums_won, :integer, :optional, "scrums_won"
    param :form, :scrums_lost, :integer, :optional, "scrums_lost"
    param :form, :successful_garryowens, :integer, :optional, "successful_garryowens"
    param :form, :unsuccessful_garryowens, :integer, :optional, "unsuccessful_garryowens"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing MatchDayPlayer"
    param :path, :id, :integer, :required, "match_day_player_id"
    param :form, :match_day_team_id, :integer, :optional, "match_day_team_id"
    param :form, :player_id, :integer, :optional, "player_id"
    param :form, :player_position_id, :integer, :optional, "player_position_id"
    param :form, :rating, :integer, :optional, "rating"
    param :form, :points, :integer, :optional, "points"
    param :form, :fouls, :integer, :optional, "fouls"
    param :form, :turnovers_for, :integer, :optional, "turnovers_for"
    param :form, :turnovers_against, :integer, :optional, "turnovers_against"
    param :form, :penalties_won, :integer, :optional, "penalties_won"
    param :form, :penalties_conceded, :integer, :optional, "penalties_conceded"
    param :form, :yellow_cards, :integer, :optional, "yellow_cards"
    param :form, :red_cards, :integer, :optional, "red_cards"
    param :form, :carries, :integer, :optional, "carries"
    param :form, :yards_carried, :integer, :optional, "yards_carried"
    param :form, :forward_passes, :integer, :optional, "forward_passes"
    param :form, :successful_lineout_throws, :integer, :optional, "successful_lineout_throws"
    param :form, :unsuccessful_lineout_throws, :integer, :optional, "unsuccessful_lineout_throws"
    param :form, :scrums_won, :integer, :optional, "scrums_won"
    param :form, :scrums_lost, :integer, :optional, "scrums_lost"
    param :form, :successful_garryowens, :integer, :optional, "successful_garryowens"
    param :form, :unsuccessful_garryowens, :integer, :optional, "unsuccessful_garryowens"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing MatchDayPlayer"
    param :path, :id, :integer, :required, "match_day_player_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a MatchDayPlayer

  def index
    respond_with MatchDayPlayer.search(player_search_params)
  end

  ##
  # Method for showing one MatchDayPlayer

  def show
    respond_with MatchDayPlayer.find(params[:id])
  end

  ##
  # Method for creating a MatchDayPlayer

  def create
    match_day_player = MatchDayPlayer.new(player_params)
    if match_day_player.save
      render json: match_day_player, status: 201, location: [:api, match_day_player]
    else
      failed_to_create(match_day_player, "match_day_player")
    end
  end

  ##
  # Method for updating a MatchDayPlayer details

  def update
    match_day_player = MatchDayPlayer.find(params[:id])
    if match_day_player.update(player_params)
      render json: match_day_player, status: 200, location: [:api, match_day_player]
    else
      failed_to_update(match_day_player, "match_day_player")
    end
  end

  ##
  # Method for deleting a MatchDayPlayer from the db

  def destroy
    match_day_player = MatchDayPlayer.find(params[:id])
    match_day_player.destroy
    head 204
  end

  private

  ##
  # Strong params for the MatchDayPlayer class.

  def player_params
    params.require(:match_day_player).permit(:player_id, :player_position_id, :rating, :points, :fouls, :turnovers_for, :turnovers_against, :penalties_won, :penalties_conceded, :yellow_cards, :red_cards, :carries, :yards_carried, :forward_passes, :successful_lineout_throws, :unsuccessful_lineout_throws, :scrums_won, :scrums_lost, :successful_garryowens, :unsuccessful_garryowens, :match_day_team_id)
  end

  ##
  # Strong params used when searching for MatchDayPlayers

  def player_search_params
    params.permit(:match_day_player_ids, :keyword)
  end

end
