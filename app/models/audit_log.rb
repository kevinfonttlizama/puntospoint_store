# app/models/audit_log.rb
class AuditLog < ActiveRecord::Base
  attr_accessible :action, :admin_id, :auditable_type, :auditable_id, :auditable

  belongs_to :admin
  belongs_to :auditable, polymorphic: true

  validates :action, presence: true
  validates :admin_id, presence: true
  validates :auditable_type, presence: true
  validates :auditable_id, presence: true
end
