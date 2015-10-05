##
# Helper method for understanding whether the current session is authenticated or not.

module Authenticable

  ##
  # Retrieves the current user (if there is one at all)

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  ##
  # Handy method for responding to API requests with a 'you need to be logged in to do this' response.

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
           status: :unauthorized unless current_user.present?
  end
  
end