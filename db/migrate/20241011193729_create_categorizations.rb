# db/migrate/XXXXXXXXXXXXXX_create_categorizations.rb
class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :category, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps
    end

    add_index :categorizations, [:category_id, :product_id], unique: true
  end
end
