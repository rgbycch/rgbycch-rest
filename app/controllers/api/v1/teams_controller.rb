##
# All CRUD operations for teams are handled in this controller

class Api::V1::TeamsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

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
      render json: { errors: team.errors }, status: 422
    end
  end

  ##
  # Method for updating a team's details

  def update
    team = Team.find(params[:id])
    if team.update(team_params)
      render json: team, status: 200, location: [:api, team]
    else
      render json: { errors: team.errors }, status: 422
    end
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
  # Strong params for the Team class.

  def team_params
    params.require(:team).permit(:title)
  end

end
