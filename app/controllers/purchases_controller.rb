# app/controllers/purchases_controller.rb
class PurchasesController < ApplicationController
  before_filter :require_admin
  before_filter :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @purchases = Purchase.includes(:customer, :product).all
  end

  def show
    # @purchase ya está establecido por set_purchase
  end

  def new
    @purchase = Purchase.new
    @products = Product.all
    @customers = Customer.all
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      redirect_to purchases_path, notice: 'Compra registrada exitosamente.'
    else
      @products = Product.all
      @customers = Customer.all
      render :new
    end
  end

  def edit
    @products = Product.all
    @customers = Customer.all
  end

  def update
    if @purchase.update_attributes(purchase_params)
      redirect_to purchases_path, notice: 'Compra actualizada exitosamente.'
    else
      @products = Product.all
      @customers = Customer.all
      render :edit
    end
  end

  def destroy
    @purchase.destroy
    redirect_to purchases_path, notice: 'Compra eliminada exitosamente.'
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:quantity, :product_id, :customer_id)
  end
end
