# spec/models/product_spec.rb
require 'spec_helper'

describe Product do
  it 'es valido con un nombre y precio' do
    product = Product.new(name: 'Producto 1', price: 100.0)
    expect(product).to be_valid
  end

  it 'no es valido sin un nombre' do
    product = Product.new(price: 100.0)
    expect(product).not_to be_valid
  end

  it 'no es valido sin un precio' do
    product = Product.new(name: 'Producto 1')
    expect(product).not_to be_valid
  end

  it 'no es valido con un precio negativo' do
    product = Product.new(name: 'Producto 1', price: -10.0)
    expect(product).not_to be_valid
  end
end
