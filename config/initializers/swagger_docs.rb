Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public",
    :base_path => "http://api.rgbycch-rest.dev",
    :clean_directory => false,
    :controller_base_path => "",
    :attributes => {
      :info => {
        "title" => "rgbycch API service",
        "description" => "API docs for rgbycch",
        "contact" => "oshea.ie@gmail.com",
        "license" => "MIT",
        "licenseUrl" => "https://opensource.org/licenses/MIT"
      }
    }
  }
})
