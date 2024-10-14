# app/controllers/api/v1/authentication_controller.rb
module Api
  module V1
    class AuthenticationController < ApplicationController
      include Swagger::Docs::Methods
      
      skip_before_filter :verify_authenticity_token

      # Documentacion Swagger para el Controlador de Autenticacion
      swagger_controller :authentication, 'Authentication'

      # Documentacion para el endpoint 'authenticate'
      swagger_api :authenticate do
        summary 'Autenticar administrador y obtener un token JWT'
        notes 'Devuelve un token JWT para usar en solicitudes posteriores'
        param :form, :email, :string, :required, 'Correo electronico del administrador'
        param :form, :password, :string, :required, 'Contrasena del administrador'
        response :ok, 'Autenticacion exitosa'
        response :unauthorized, 'Credenciales invalidas'
      end

      def authenticate
        admin = Admin.find_by_email(params[:email])
        if admin && admin.authenticate(params[:password])
          payload = { admin_id: admin.id }
          token = JWT.encode(payload, Rails.application.config.secret_token)
          render json: { auth_token: token }
        else
          render json: { error: 'Credenciales invalidas' }, status: :unauthorized
        end
      end
    end
  end
end
