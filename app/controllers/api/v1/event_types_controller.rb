##
# All CRUD and search operations for event types are handled in this controller

class Api::V1::EventTypesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :event_types, "Event Types"

  # :nocov:
  swagger_api :index do
    summary "Searches for an Event Type"
    param :query, :event_type_ids, :string, :optional, "event_type_ids"
    param :query, :keyword, :string, :optional, "keyword"
    response :ok, "Success", :event_types
    response :not_acceptable
    response :not_found
  end

  swagger_api :show do
    summary "Gets an Event Type"
    param :path, :id, :integer, :required, "event_type_id"
    response :ok, "Success", :event_type
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Event Type"
    param :form, :title, :string, :required, "title"
    param :form, :url, :string, :optional, "url"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Event Type"
    param :path, :id, :integer, :required, "event_type_id"
    param :form, :title, :string, :optional, "title"
    param :form, :url, :string, :optional, "url"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Event Type"
    param :path, :id, :integer, :required, "event_type_id"
    response :unauthorized
    response :not_found
  end
  # :nocov:

  ##
  # Method for searching for an event type

  def index
    respond_with EventType.search(event_type_search_params)
  end

  ##
  # Method for showing one event type

  def show
    respond_with EventType.find(params[:id])
  end

  ##
  # Method for creating an event type

  def create
    event_type = EventType.new(event_type_params)
    if event_type.save
      render json: event_type, status: 201, location: [:api, event_type]
    else
      failed_to_create(event_type, "event_type")
    end
  end

  ##
  # Method for updating an event type's details

  def update
    event_type = EventType.find(params[:id])
    if event_type.update(event_type_params)
      render json: event_type, status: 200, location: [:api, event_type]
    else
      failed_to_update(event_type, "event_type")
    end
  end

  ##
  # Method for deleting an event type from the db

  def destroy
    event_type = EventType.find(params[:id])
    event_type.destroy
    head 204
  end

  private

  ##
  # Strong params for the EventType class.

  def event_type_params
    params.require(:event_type).permit(:title, :url)
  end

  ##
  # Strong params used when searching for EventTypes

  def event_type_search_params
    params.permit(:event_type_ids, :keyword)
  end

end
