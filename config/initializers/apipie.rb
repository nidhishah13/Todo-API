Apipie.configure do |config|
  config.app_name                = "TodosApi"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  config.translate = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"

  config.swagger_include_warning_tags = true
  config.swagger_suppress_warnings = true
  config.swagger_api_host = 'localhost:3000'
end
