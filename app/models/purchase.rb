# app/models/purchase.rb
class Purchase < ActiveRecord::Base
  attr_accessible :quantity, :product_id, :customer_id, :price, :customer


  belongs_to :customer
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :customer_id, presence: true
  validates :product_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  after_create :send_first_purchase_email

  def total_price
    quantity * product.price
  end

  private

  def send_first_purchase_email
    # Verificar si es la primera compra del producto
    if product.purchases.count == 1
      # Ejecutar el worker para enviar el email
      FirstPurchaseEmailWorker.perform_async(product.id, self.id)
    end
  end
end
