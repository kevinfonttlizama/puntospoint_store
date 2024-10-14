# spec/models/categorization_spec.rb
require 'spec_helper'

describe Categorization do
  it 'es valido con category_id y product_id' do
    categorization = Categorization.new(category_id: 1, product_id: 1)
    expect(categorization).to be_valid
  end

  it 'no es valido sin category_id' do
    categorization = Categorization.new(product_id: 1)
    expect(categorization).not_to be_valid
  end

  it 'no es valido sin product_id' do
    categorization = Categorization.new(category_id: 1)
    expect(categorization).not_to be_valid
  end
end
