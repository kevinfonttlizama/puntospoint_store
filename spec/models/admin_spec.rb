# spec/models/admin_spec.rb
# encoding: utf-8

require 'spec_helper'

describe Admin do
  it 'es valido con nombre, email y password' do
    admin = Admin.new(
      name: 'Admin User',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(admin).to be_valid
  end

  it 'no es valido sin un nombre' do
    admin = Admin.new(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(admin).not_to be_valid
    expect(admin.errors[:name]).to include("can't be blank")
  end

  it 'no es valido sin un email' do
    admin = Admin.new(
      name: 'Admin User',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(admin).not_to be_valid
    expect(admin.errors[:email]).to include("can't be blank")
  end

  it 'no es valido sin un password' do
    admin = Admin.new(
      name: 'Admin User',
      email: 'admin@example.com'
    )
    expect(admin).not_to be_valid
    expect(admin.errors[:password]).to include("can't be blank")
  end

  it 'no es valido con un email duplicado' do
    Admin.create!(
      name: 'Admin User',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    duplicate_admin = Admin.new(
      name: 'Another Admin',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(duplicate_admin).not_to be_valid
    expect(duplicate_admin.errors[:email]).to include('has already been taken')
  end
end
