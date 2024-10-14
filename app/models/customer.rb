# app/models/customer.rb
class Customer < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :name, :email, :password

  has_many :purchases
  has_many :products, through: :purchases

  validates :name, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, uniqueness: true
end
