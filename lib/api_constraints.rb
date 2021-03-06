##
# Class used for versioning the API.

class ApiConstraints

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.rgbycch.v#{@version}")
  end

end