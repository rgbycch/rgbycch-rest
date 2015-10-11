##
# Helper method for communicating common API errors back to clients

module Errorable

  ##
  # Used whenever a record for a specific id is not found.
  # Typically, this would happen when requesting a specific id, or trying to update/destroy
  # a record which is not present in the DB.

  def record_not_found
    render json: "{\"error\":\"Record Not Found\"}", status: 404
  end

  ##
  # Used whenever a user tries to create a new record, but either validation of the record fails or the db is down.

  def failed_to_create(model, model_name)
    logger.warn("Creating a new #{model_name} failed with #{model.errors.full_messages}")
    render_error(model)
  end

  ##
  # Used whenever a user tries to update an existing record, but either validation of the record fails or the db is down.

  def failed_to_update(model, model_name)
    logger.warn("Updating an existing #{model_name} failed with #{model.errors.full_messages}")
    render_error(model)
  end

  private

  ##
  # Renders the error back to the user with the appropriate status code.

  def render_error(model)
    render json: { errors: model.errors }, status: 422
  end

end