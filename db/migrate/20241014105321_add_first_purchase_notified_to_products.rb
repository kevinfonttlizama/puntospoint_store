class AddFirstPurchaseNotifiedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :first_purchase_notified, :boolean
  end
end
