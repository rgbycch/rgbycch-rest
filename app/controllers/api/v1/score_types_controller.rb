##
# All CRUD operations for score types are handled in this controller

class Api::V1::ScoreTypesController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!

  ##
  # Method for showing one event type

  def show
    respond_with ScoreType.find(params[:id])
  end

  ##
  # Method for creating a score type

  def create
    score_type = ScoreType.new(score_type_params)
    if score_type.save
      render json: score_type, status: 201, location: [:api, score_type]
    else
      render json: { errors: score_type.errors }, status: 422
    end
  end

  ##
  # Method for updating a score type's details

  def update
    score_type = ScoreType.find(params[:id])
    if score_type.update(score_type_params)
      render json: score_type, status: 200, location: [:api, score_type]
    else
      render json: { errors: score_type.errors }, status: 422
    end
  end

  ##
  # Method for deleting a score type from the db

  def destroy
    score_type = ScoreType.find(params[:id])
    score_type.destroy
    head 204
  end

  private

  ##
  # Strong params for the ScoreType class.

  def score_type_params
    params.require(:score_type).permit(:title, :url, :points)
  end

end
