# spec/support/controller_helpers.rb
module ControllerHelpers
  def authenticate_admin!
    @admin = Admin.create!(
      name: 'Admin User',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    payload = { admin_id: @admin.id }
    token = JWT.encode(payload, Rails.application.config.secret_token, 'HS256')  # Especificar algoritmo
    request.headers['Authorization'] = "Bearer #{token}"  # Usar headers en lugar de env
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
end
