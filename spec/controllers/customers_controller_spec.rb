require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  context 'Teste Rota' do
    it 'Route' do
      is_expected.to route(:get, '/customers').to(action: :index)
    end

  end

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

  describe 'as Logged Member' do
    before do
      @member = create(:member)
      @customer = create(:customer)
    end

    context 'Testando usuário não autenticado não pode fazer essa ação retorna status code 302  não autorizado' do
      it 'returns a http status 302 (not authorizad)' do
        get :show, params: { id: @customer.id }
        expect(response).to have_http_status(302)
      end
    end

    context "Testando usuario com autorização" do
      it '#show' do
        sign_in @member
        get :show, params: { id: @customer.id }
        expect(response).to have_http_status(200)
      end

      it 'with valid attributes' do
        customer_params = attributes_for(:customer)
        sign_in @member
        expect {
          post :create, params: { customer: customer_params }
        }.to change(Customer, :count).by(1)
      end

      it 'with invalid attributes' do
        customer_params = attributes_for(:customer, address: nil)
        sign_in @member
        expect {
          post :create, params: { customer: customer_params }
        }.not_to change(Customer, :count)
      end

      it 'Content-Type JSON' do
        customer_params = attributes_for(:customer)
        sign_in @member
        post :create, format: :json, params: { customer: customer_params }
        expect(response.content_type).to eq('application/json')
      end

      it 'Flash Notice' do
        customer_params = attributes_for(:customer)
        sign_in @member
        post :create, params: { customer: customer_params }
        expect(flash[:notice]).to match(/successfully created/)
      end
    end
  end
end