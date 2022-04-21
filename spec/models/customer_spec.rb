require 'rails_helper'

RSpec.describe Customer, type: :model do

  it 'full_name' do
    customer = create(:user) # por conta do alias podemos usar customer ou user
    expect(customer.full_name).to start_with("Sr. ")
  end

  it 'herança' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it 'sobre-escrever atributos' do
    customer = create(:customer, name: "Guilherme Marcelino" )
    expect(customer.full_name).to eq("Sr. Guilherme Marcelino")
  end

  # testando se vou criado um customer pela quatidade de customers existente depois da criação
  it { expect{ create(:customer) }.to change {Customer.all.size}.by(1) }

  it 'Usando o attributes_for' do
    #  attributes_for vai extrair atributos determinada factory
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with("Sr. ")
    puts attrs
  end

  it 'Atributo Transitorio' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end


end
