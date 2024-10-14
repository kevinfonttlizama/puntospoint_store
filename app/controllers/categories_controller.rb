# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  before_filter :require_admin
  before_filter :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  
    # Responder siempre con un array, incluso si está vacío, con status 200
    render json: {
      message: @categories.any? ? 'Categories found' : 'No categories found',
      data: @categories
    }, status: :ok
  end
  
  def show
    # @category ya está establecido por set_category
  end

  def new
    @category = current_admin.categories.build
  end

  def create
    @category = current_admin.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Categoria creada exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to categories_path, notice: 'Categoria actualizada exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'Categoria eliminada exitosamente.'
  end

  private

  def set_category
    @category = current_admin.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
