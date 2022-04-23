require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it "works! 200 OK" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "index - JSON 200 OK" do
      get "http://localhost:3000/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
                                 id: (be_kind_of Integer),
                                 name: (be_kind_of String),
                                 email: (be_kind_of String)
                                            ])
    end

    it "show - JSON 200 OK" do
      get "/customers/1.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
                                 id: /\d/,
                                 name: (be_kind_of String),
                                 email: (be_kind_of String)
                                            )
    end

    # it 'create - JSON' do
    #   member = create(:member)
    #   debugger
    #   login_as(member, scope: :member)
    #
    #   headers = { "ACCEPT" => "application/json" }
    #
    #   customers_params = attributes_for(:customer)
    #   post "/customers.json", params: { custom: customers_params}, headers: headers
    #   expect(response.body).to include_json(
    #                              id: /\d/,
    #                              name: (be_kind_of String),
    #                              email: (be_kind_of String)
    #                            )
    # end
  end
end
