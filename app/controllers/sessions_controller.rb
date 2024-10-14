# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # Renderiza el formulario de inicio de sesión
  end

  def create
    admin = Admin.find_by_email(params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to root_path, notice: 'Inicio de sesion exitoso'
    else
      flash.now[:alert] = 'Correo electronico o pass invalidos'
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_path, notice: 'Sesion cerrada exitosamente'
  end
end
