##
# All CRUD and search operations for clubs are handled in this controller

class Api::V1::ClubsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  ##
  # Method for searching for a club

  def index
    respond_with Club.search(club_search_params)
  end

  ##
  # Method for showing one club

  def show
    respond_with Club.find(params[:id])
  end

  ##
  # Method for creating a club

  def create
    club = Club.new(club_params)
    if club.save
      render json: club, status: 201, location: [:api, club]
    else
      render json: { errors: club.errors }, status: 422
    end
  end

  ##
  # Method for updating a club's details

  def update
    club = Club.find(params[:id])
    if club.update(club_params)
      render json: club, status: 200, location: [:api, club]
    else
      render json: { errors: club.errors }, status: 422
    end
  end

  ##
  # Method for deleting a club from the db

  def destroy
    club = Club.find(params[:id])
    club.destroy
    head 204
  end

  private

  ##
  # Strong params for the Club class.

  def club_params
    params.require(:club).permit(:name, :url, :founded)
  end

  ##
  # Strong params used when searching for Clubs

  def club_search_params
    params.permit(:club_ids, :keyword)
  end

end
