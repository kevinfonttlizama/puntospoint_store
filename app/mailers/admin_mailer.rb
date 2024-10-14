class AdminMailer < ActionMailer::Base
  default from: 'no-reply@puntospoint.com'

  def first_purchase_notification(product, purchase, admin_creator, other_admins)
    @product = product
    @purchaser = purchase.customer

    mail(
      to: admin_creator.email,
      cc: other_admins.map(&:email),
      subject: "First Purchase of #{product.name}"
    )
  end




end
