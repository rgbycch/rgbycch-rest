##
# All CRUD and search operations for clubs are handled in this controller

class Api::V1::ClubsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :clubs, "Clubs"

  swagger_api :index do
    summary "Searches for a Club"
    param :query, :club_ids, :string, :optional, "club_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :clubs
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Club"
    param :path, :id, :integer, :required, "club_id"
    response :ok, "Success", :club
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Club"
    param :form, :name, :string, :required, "name"
    param :form, :url, :string, :optional, "url"
    param :form, :founded, :string, :optional, "founded"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Club"
    param :path, :id, :integer, :required, "club_id"
    param :form, :name, :string, :optional, "name"
    param :form, :url, :string, :optional, "url"
    param :form, :founded, :string, :optional, "founded"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Club"
    param :path, :id, :integer, :required, "club_id"
    response :unauthorized
    response :not_found
  end

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
