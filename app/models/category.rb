# app/models/category.rb
class Category < ActiveRecord::Base
  attr_accessible :name, :admin_id


  # Callbacks
  after_create :log_create_action
  after_update :log_update_action
  after_destroy :log_destroy_action

  belongs_to :admin
  has_many :categorizations, dependent: :destroy
  has_many :products, through: :categorizations
  has_many :audit_logs, as: :auditable, dependent: :destroy


  validates :name, presence: true, uniqueness: true
  private

  def log_create_action
    AuditLog.create!(admin_id: self.admin_id, auditable: self, action: 'created')
  end

  def log_update_action
    AuditLog.create!(admin_id: self.admin_id, auditable: self, action: 'updated')
  end

  def log_destroy_action
    AuditLog.create!(admin_id: self.admin_id, auditable: self, action: 'destroyed')
  end
end
