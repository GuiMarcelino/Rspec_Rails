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
end
