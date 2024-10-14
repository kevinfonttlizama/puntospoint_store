# app/models/product.rb
class Product < ActiveRecord::Base

    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  attr_accessible :name, :price, :category_ids, :admin_id, :images, :image
  belongs_to :admin
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :purchases, dependent: :destroy
  has_many :customers, through: :purchases

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create :log_creation
  
  def log_creation
    AuditLog.create!(
      admin_id: self.admin_id,
      auditable_type: 'Product',
      auditable_id: self.id,
      action: 'create'
    )
  end
end
