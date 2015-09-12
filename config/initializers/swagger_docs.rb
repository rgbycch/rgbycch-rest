Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/api/v1/",
    :base_path => "http://api.rgbycch.com",
    :clean_directory => false,
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
