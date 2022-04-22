require 'rails_helper'

RSpec.describe Product, type: :model do

  # teste do model com os todos os atributos validos
  it 'is valid with description, price and category' do
    product = create(:product)
    expect(product).to be_valid
  end

  # 3 testes para campos nulos description, price e category
  it 'is invalid without description' do
    product = build(:product, description: nil)
    product.valid?
    expect(product.errors[:description]).to include("can't be blank")
  end

  it 'is invalid without price' do
    product = build(:product, price: nil)
    product.valid?
    expect(product.errors[:price]).to include("can't be blank")
  end

  it 'is invalid without category' do
    product = build(:product, category: nil)
    product.valid?
    expect(product.errors[:category]).to include("can't be blank")
  end

  context  'Instance Methods' do
    # teste método de classe
    it 'return a product with a full description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end

  context 'Validates' do
    # validando a presenca dos campos preenchidos com is_expectd usando a gem shoulda matchers
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:category) }
  end

  context  'Associations' do
    # testando relacionamento products e categories, pois o produto pertencem a uma categoria.
    it { is_expected.to belong_to(:category) }
  end
end
