# app/controllers/api/v1/purchases_controller.rb
module Api
  module V1
    class PurchasesController < ApplicationController
      include Swagger::Docs::Methods
      before_filter :authenticate_request!

      # Documentacion Swagger para el Controlador de Compras
      swagger_controller :purchases, 'Purchase Management'

      # Documentacion para el endpoint 'index'
      swagger_api :index do
        summary 'Obtener una lista de compras basadas en parametros'
        param :query, :from_date, :string, :optional, 'Fecha de inicio (YYYY-MM-DD)'
        param :query, :to_date, :string, :optional, 'Fecha de fin (YYYY-MM-DD)'
        param :query, :category_id, :integer, :optional, 'ID de la categoria'
        param :query, :customer_id, :integer, :optional, 'ID del cliente'
        param :query, :admin_id, :integer, :optional, 'ID del administrador'
        response :ok, 'Exito'
        response :unauthorized, 'No autorizado'
      end

      def index
        @purchases = Purchase.includes(:product, :customer)

        if params[:from_date].present? && params[:to_date].present?
          @purchases = @purchases.where(created_at: params[:from_date]..params[:to_date])
        end

        if params[:category_id].present?
          @purchases = @purchases.joins(product: :categories).where(categories: { id: params[:category_id] })
        end

        if params[:customer_id].present?
          @purchases = @purchases.where(customer_id: params[:customer_id])
        end

        if params[:admin_id].present?
          @purchases = @purchases.joins(product: :admin).where(products: { admin_id: params[:admin_id] })
        end

        render json: @purchases.as_json(include: [:product, :customer])
      end

      # Documentacion para el endpoint 'by_granularity'
      swagger_api :by_granularity do
        summary 'Obtener el numero de compras basado en granularidad'
        param :query, :from_date, :string, :optional, 'Fecha de inicio (YYYY-MM-DD)'
        param :query, :to_date, :string, :optional, 'Fecha de fin (YYYY-MM-DD)'
        param :query, :category_id, :integer, :optional, 'ID de la categoria'
        param :query, :customer_id, :integer, :optional, 'ID del cliente'
        param :query, :admin_id, :integer, :optional, 'ID del administrador'
        param :query, :granularity, :string, :required, 'Granularidad (hour, day, week, month, year)'
        response :ok, 'Exito'
        response :bad_request, 'Granularidad invalida'
        response :unauthorized, 'No autorizado'
      end

      def by_granularity
        granularity = params[:granularity] || 'day'
        @purchases = Purchase.scoped

        # Aplicar los mismos filtros que en 'index'
        if params[:from_date].present? && params[:to_date].present?
          from_date = params[:from_date].to_date.beginning_of_day
          to_date = params[:to_date].to_date.end_of_day
          @purchases = @purchases.where("created_at >= ? AND created_at <= ?", from_date, to_date)
        end

        if params[:category_id].present?
          @purchases = @purchases.joins(product: :categories).where(categories: { id: params[:category_id] })
        end

        if params[:customer_id].present?
          @purchases = @purchases.where(customer_id: params[:customer_id])
        end

        if params[:admin_id].present?
          @purchases = @purchases.joins(product: :admin).where(products: { admin_id: params[:admin_id] })
        end

        # Definir el formato y el group_by según la granularidad
        case granularity
        when 'hour'
          format = '%Y-%m-%d %H:00'
          group_by = "TO_CHAR(DATE_TRUNC('hour', purchases.created_at), 'YYYY-MM-DD HH24:00')"
        when 'day'
          format = '%Y-%m-%d'
          group_by = "TO_CHAR(DATE_TRUNC('day', purchases.created_at), 'YYYY-MM-DD')"
        when 'week'
          format = '%Y-%W'
          group_by = "TO_CHAR(DATE_TRUNC('week', purchases.created_at), 'IYYY-IW')"
        when 'month'
          format = '%Y-%m'
          group_by = "TO_CHAR(DATE_TRUNC('month', purchases.created_at), 'YYYY-MM')"
        when 'year'
          format = '%Y'
          group_by = "TO_CHAR(DATE_TRUNC('year', purchases.created_at), 'YYYY')"
        else
          render json: { error: 'Granularidad invalida' }, status: :bad_request
          return
        end

        # Realizar el agrupamiento y conteo
        counts = @purchases.group(group_by).count

        # Las claves ya están formateadas, solo renderizamos el hash
        render json: counts
      end
    end
  end
end
