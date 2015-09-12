##
# Main entry point into the application. Minimal logic here.

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Authenticable
end
