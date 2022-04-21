require 'rails_helper'

RSpec.describe Customer, type: :model do

  it 'full_name' do
    customer = create(:user) # por conta do alias podemos usar customer ou user
    puts customer.email
    expect(customer.full_name).to start_with("Sr. ")
  end

  it 'herança' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it 'sobre-escrever atributos' do
    customer = create(:customer, name: "Guilherme Marcelino")
    expect(customer.full_name).to eq("Sr. Guilherme Marcelino")
  end

  # testando se vou criado um customer pela quatidade de customers existente depois da criação
  it { expect { create(:customer) }.to change { Customer.all.size }.by(1) }

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

  it 'Cliente Masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it 'Cliente Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end

  it 'travel to' do
    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @customer = create(:customer_vip)
    end
    puts @customer.created_at
    puts Time.now
    expect(@customer.created_at).to be < Time.now
  end
  it 'Cliente Feminino' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
  end

  it 'Cliente Feminino Default' do
    customer = create(:customer_female_default)
    expect(customer.gender).to eq('F')
  end

end
