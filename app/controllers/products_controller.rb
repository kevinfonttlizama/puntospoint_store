# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_filter :require_admin
  before_filter :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.includes(:categories).all
  end

  def show
    # @product ya está establecido por set_product
  end

  def new
    @product = current_admin.products.build
    @categories = Category.all
  end

  def create
    @product = current_admin.products.build(product_params) # Asegúrate de que product_params esté correcto
    if @product.save
      redirect_to products_path, notice: 'Producto creado exitosamente.'
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to products_path, notice: 'Producto actualizado exitosamente.'
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Producto eliminado exitosamente.'
  end

  private

  def set_product
    @product = current_admin.products.find(params[:id])
  end

  def product_params
    params[:product].slice(:name, :price, :admin_id, :category_ids, :images)
  end
  
end
