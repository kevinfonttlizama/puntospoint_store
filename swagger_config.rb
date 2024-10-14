# config/swagger_config.rb

# Configuración de Swagger
Swagger::Docs::Config.base_api_controller = ActionController::Base

# Configuración de la documentación
Swagger::Docs::Config.swagger_version = '2.0'
Swagger::Docs::Config.base_path = '/api'