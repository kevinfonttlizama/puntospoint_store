# spec/models/category_spec.rb
# encoding: utf-8

require 'spec_helper'

describe Category do
  it 'es valido con un nombre' do
    category = Category.new(name: 'Electronics')
    expect(category).to be_valid
  end

  it 'no es valido sin un nombre' do
    category = Category.new
    expect(category).not_to be_valid
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'no es valido con un nombre duplicado' do
    Category.create!(name: 'Electronics')
    duplicate_category = Category.new(name: 'Electronics')
    expect(duplicate_category).not_to be_valid
    expect(duplicate_category.errors[:name]).to include('has already been taken')
  end
end
