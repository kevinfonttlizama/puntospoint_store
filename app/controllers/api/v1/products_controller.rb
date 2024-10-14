# app/controllers/api/v1/products_controller.rb
module Api
  module V1
    class ProductsController < ApplicationController
      include Swagger::Docs::Methods

      before_filter :authenticate_request!

      # Documentación Swagger para el Controlador de Productos
      swagger_controller :products, 'Product Management'

      # Documentación para el endpoint 'most_purchased'
      swagger_api :most_purchased do
        summary 'Obtener los productos mas comprados por categoria'
        notes 'Devuelve una lista de productos ordenados por la cantidad de compras en cada categoria'
        param :query, :category_id, :integer, :optional, 'ID de la categoria'
        response :ok, 'exito'
        response :unauthorized, 'No autorizado'
      end

      def most_purchased
        category_id = params[:category_id]

        @products = Product.joins(:purchases, :categories)
                           .select('products.*, COUNT(purchases.id) as purchases_count, categories.id as category_id')
                           .group('products.id, categories.id')
                           .order('purchases_count DESC')

        @products = @products.where(categories: { id: category_id }) if category_id.present?

        render json: @products.as_json(methods: :purchases_count)
      end

      # Documentación para el endpoint 'top_earning'
      swagger_api :top_earning do
        summary 'Obtener los 3 productos con mayores ingresos por categoria'
        notes 'Devuelve una lista de los 3 productos con mayores ingresos en cada categoria'
        param :query, :category_id, :integer, :optional, 'ID de la categoria'
        response :ok, 'exito'
        response :unauthorized, 'No autorizado'
      end

      def top_earning
        category_id = params[:category_id]

        @products = Product.joins(:purchases, :categories)
                           .select('products.*, SUM(purchases.quantity * products.price) as total_earned, categories.id as category_id')
                           .group('products.id, categories.id')
                           .order('total_earned DESC')
                           .limit(3)

        @products = @products.where(categories: { id: category_id }) if category_id.present?

        render json: @products.as_json(methods: :total_earned)
      end
    end
  end
end
