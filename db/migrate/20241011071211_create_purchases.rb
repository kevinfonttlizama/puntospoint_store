class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :product
      t.references :customer
      t.integer :quantity

      t.timestamps
    end
    add_index :purchases, :product_id
    add_index :purchases, :customer_id
  end
end
