# config/initializers/swagger_docs.rb

Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/api/v1/",
    :base_path => "http://localhost:3000",
    :clean_directory => false,
    :parent_controller => ApplicationController, # Asegurate de que este controlador exista
    :attributes => {
      :info => {
        "title" => "Ecommerce API",
        "description" => "Documentacion de la API para gestionar productos, compras y clientes", # Sin acentos
        "contact" => "support@ecommerce.com",
        "license" => "MIT",
        "licenseUrl" => "https://opensource.org/licenses/MIT"
      }
    }
  }
})
