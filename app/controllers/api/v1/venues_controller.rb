##
# All CRUD and search operations for venues are handled in this controller

class Api::V1::VenuesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :venues, "Venues"

  # :nocov:
  swagger_api :index do
    summary "Searches for a Venue"
    param :query, :venue_ids, :string, :optional, "venue_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :venues
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets a Venue"
    param :path, :id, :integer, :required, "venue_id"
    response :ok, "Success", :venue
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Venue"
    param :form, :title, :string, :required, "title"
    param :form, :latitude, :float, :required, "latitude"
    param :form, :longitue, :float, :required, "longitue"
    param :form, :capacity, :integer, :optional, "capacity"
    param :form, :url, :string, :optional, "url"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Venue"
    param :path, :id, :integer, :required, "venue_id"
    param :form, :title, :string, :optional, "title"
    param :form, :latitude, :float, :optional, "latitude"
    param :form, :longitue, :float, :optional, "longitue"
    param :form, :capacity, :integer, :optional, "capacity"
    param :form, :url, :string, :optional, "url"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Venue"
    param :path, :id, :integer, :required, "venue_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for a Venue

  def index
    respond_with Venue.search(venue_search_params)
  end

  ##
  # Method for showing one venue

  def show
    respond_with Venue.find(params[:id])
  end

  ##
  # Method for creating a Venue

  def create
    venue = Venue.new(venue_params)
    if venue.save
      render json: venue, status: 201, location: [:api, venue]
    else
      failed_to_create(venue, "venue")
    end
  end

  ##
  # Method for updating a Venue's details

  def update
    venue = Venue.find(params[:id])
    if venue.update(venue_params)
      render json: venue, status: 200, location: [:api, venue]
    else
      failed_to_update(venue, "venue")
    end
  end

  ##
  # Method for deleting a Venue from the db

  def destroy
    venue = Venue.find(params[:id])
    venue.destroy
    head 204
  end

  private

  ##
  # Strong params for the Venue class.

  def venue_params
    params.require(:venue).permit(:title, :url, :latitude, :longitude, :capacity)
  end

  ##
  # Strong params used when searching for Venues

  def venue_search_params
    params.permit(:venue_ids, :keyword)
  end

end
