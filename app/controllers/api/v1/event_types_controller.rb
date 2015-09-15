##
# All CRUD operations for event types are handled in this controller

class Api::V1::EventTypesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

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
      render json: { errors: event_type.errors }, status: 422
    end
  end

  ##
  # Method for updating an event type's details

  def update

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

end
