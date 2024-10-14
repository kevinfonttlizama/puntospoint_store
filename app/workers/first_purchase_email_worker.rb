# app/workers/first_purchase_email_worker.rb
class FirstPurchaseEmailWorker
  include Sidekiq::Worker

  def perform(product_id, purchase_id)
    product = Product.find(product_id)
    purchase = Purchase.find(purchase_id)

    # Obtener el admin que creó el producto
    admin_creator = product.admin

    # Obtener todos los admins excepto el creador del producto
    # Uso de una sintaxis compatible con Rails 3.2.22
    other_admins = Admin.where("id != ?", admin_creator.id)

    # Enviar el correo
    AdminMailer.first_purchase_notification(product, purchase, admin_creator, other_admins).deliver
  end
end
