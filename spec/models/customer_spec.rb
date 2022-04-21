require 'rails_helper'

RSpec.describe Customer, type: :model do

  it 'full_name' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr. ")
  end
  # testando se vou criado um customer pela quatidade de customers existente depois da criação
  it { expect{ create(:customer) }.to change {Customer.all.size}.by(1) }

end
