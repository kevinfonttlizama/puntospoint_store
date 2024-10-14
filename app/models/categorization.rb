# app/models/categorization.rb
class Categorization < ActiveRecord::Base
  attr_accessible :category_id, :product_id

  belongs_to :category
  belongs_to :product

  validates :category_id, presence: true
  validates :product_id, presence: true
end
