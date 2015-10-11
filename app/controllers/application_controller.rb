##
# Main entry point into the application. Minimal logic here.

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Authenticable
  include Errorable

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def failed_to_create(model, model_name)
    logger.warn("Creating a new #{model_name} failed with #{model.errors.full_messages}")
    render_error(model)
  end

  def failed_to_update(model, model_name)
    logger.warn("Updating an existing #{model_name} failed with #{model.errors.full_messages}")
    render_error(model)
  end

  private

  def render_error(model)
    render json: { errors: model.errors }, status: 422
  end

end
