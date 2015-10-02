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

end