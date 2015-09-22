##
# All CRUD operations for a player's preferred position is handled in this controller

class Api::V1::PreferredPositionsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  ##
  # Method for showing one event type

  def show
    respond_with PreferredPosition.find(params[:id])
  end

  ##
  # Method for creating a preferred position

  def create
    preferred_position = PreferredPosition.new(preferred_position_params)
    if preferred_position.save
      render json: preferred_position, status: 201, location: [:api, preferred_position]
    else
      render json: { errors: preferred_position.errors }, status: 422
    end
  end

  ##
  # Method for updating a preferred position details

  def update
    preferred_position = PreferredPosition.find(params[:id])
    if preferred_position.update(preferred_position_params)
      render json: preferred_position, status: 200, location: [:api, preferred_position]
    else
      render json: { errors: preferred_position.errors }, status: 422
    end
  end

  ##
  # Method for deleting a preferred position from the db

  def destroy
    preferred_position = PreferredPosition.find(params[:id])
    preferred_position.destroy
    head 204
  end

  private

  ##
  # Strong params for the PreferredPosition class.

  def preferred_position_params
    params.require(:preferred_position).permit(:preference, :player_id, :player_position_id)
  end
end
