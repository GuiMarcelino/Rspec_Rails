require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  context 'Testando uma requisição não autenticada' do

    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'returns a http status 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context 'Testando usuário não autenticado não pode fazer essa ação retorna status code 302  não autorizado' do
    it 'returns a http status 302 (not authorizad)' do
      customer = create(:customer)
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(302)
    end
  end

  context  "Testando usuario com autorização" do
    it '#show' do
      member = create(:member)
      customer = create(:customer)

      sign_in member
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(200)
    end
  end
end
