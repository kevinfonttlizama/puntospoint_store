# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session  # Maneja solicitudes API sin CSRF

  helper_method :current_admin

  private

  # Método para obtener el admin actual basado en el token JWT
  def current_admin
    @current_admin ||= Admin.find(auth_token['admin_id']) if auth_token
  end

  # Método de autenticación antes de acciones protegidas
  def authenticate_request!
    unless admin_id_in_token?
      render json: { errors: ['No autorizado'] }, status: :unauthorized
      return
    end
    @current_admin = Admin.find(auth_token['admin_id'])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError, JWT::VerificationError
    render json: { errors: ['No autorizado'] }, status: :unauthorized
  end

  # Definir require_admin para utilizar authenticate_request!
  def require_admin
    authenticate_request!
  end

  # Extrae el token JWT del encabezado Authorization
  def http_token
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      @http_token ||= token
    end
  end

  # Decodifica el token JWT
  def auth_token
    if http_token
      begin
        @auth_token ||= JWT.decode(http_token, Rails.application.config.secret_token, true, algorithm: 'HS256')[0]
      rescue JWT::DecodeError, JWT::VerificationError
        nil
      end
    end
  end

  # Verifica si el token contiene un admin_id válido
  def admin_id_in_token?
    http_token && auth_token && auth_token['admin_id'].present?
  end
end
