# app/models/admin.rb
class Admin < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true

  # Asociaciones
  has_many :products
  has_many :categories
  has_many :audit_logs
end
