# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
  before_filter :require_admin
  before_filter :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
    # @customer ya está establecido por set_customer
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: 'Cliente creado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(customer_params)
      redirect_to customers_path, notice: 'Cliente actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: 'Cliente eliminado exitosamente.'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end
