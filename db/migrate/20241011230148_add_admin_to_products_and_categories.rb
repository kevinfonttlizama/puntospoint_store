class AddAdminToProductsAndCategories < ActiveRecord::Migration
  def change
    add_column :products, :admin_id, :integer
    add_column :categories, :admin_id, :integer
    add_index :products, :admin_id
    add_index :categories, :admin_id
  end
end
