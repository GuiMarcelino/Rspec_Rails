require 'rails_helper'

RSpec.describe Customer, type: :model do
  fixtures :all

  it 'Create a Customer' do
    customer = customers(:guilherme)
    expect(customer.full_name).to eq("Sr. Guilherme Marcelino")
  end
end
