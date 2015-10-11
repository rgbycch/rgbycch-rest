##
# All CRUD operations for a player's preferred position is handled in this controller

class Api::V1::PreferredPositionsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  swagger_controller :preferred_positions, "Preferred Positions"

  swagger_api :show do
    summary "Gets a Preferred Position"
    param :path, :id, :integer, :required, "preferred_position_id"
    response :ok, "Success", :preferred_position
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Preferred Position"
    param :form, :player_id, :string, :required, "player_id"
    param :form, :player_position_id, :string, :required, "player_position_id"
    param :form, :preference, :integer, :required, "preference"
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing Preferred Position"
    param :path, :id, :integer, :required, "preferred_position_id"
    param :form, :player_id, :string, :optional, "player_id"
    param :form, :player_position_id, :string, :optional, "player_position_id"
    param :form, :preference, :integer, :optional, "preference"
    response :unauthorized
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Deletes an existing Preferred Position"
    param :path, :id, :integer, :required, "preferred_position_id"
    response :unauthorized
    response :not_found
  end

  ##
  # Method for showing one preferred position

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
      failed_to_create(preferred_position, "preferred_position")
    end
  end

  ##
  # Method for updating a preferred position details

  def update
    preferred_position = PreferredPosition.find(params[:id])
    if preferred_position.update(preferred_position_params)
      render json: preferred_position, status: 200, location: [:api, preferred_position]
    else
      failed_to_update(preferred_position, "preferred_position")
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
