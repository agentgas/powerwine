require 'rails_helper'

RSpec.describe "Wines", type: :request do
  before(:all) do
    Wine.delete_all
  end

  describe 'GET /api/wines' do
    context "when there is no price range" do
      let!(:wine1) { Wine.create(name: "Cheval Vert", producer: "Saint-Emilion", year: 1983, price: 150) }
      let!(:wine2) { Wine.create(name: "Cheval Rouge", producer: "Saint-Emilion", year: 1983, price: 100) }

      it 'should return status code 200' do
        get '/api/wines'

        expect(response).to have_http_status(200)
      end

      it 'should return all wines' do
        get '/api/wines'
        res = [
          {
              "id": wine1.id,
              "name": "Cheval Vert",
              "producer": "Saint-Emilion",
              "year": 1983,
              "evaluation": nil,
              "price": 150
          },
          {
              "id": wine2.id,
              "name": "Cheval Rouge",
              "producer": "Saint-Emilion",
              "year": 1983,
              "evaluation": nil,
              "price": 100
          }
        ]
        
        expect(response.body).not_to be_empty
        expect(JSON.parse(response.body)).to eq(res.as_json)
      end
    end

    context "when there is price range" do
      let!(:wine1) { Wine.create(name: "Cheval Vert", producer: "Saint-Emilion", year: 1983, price: 150) }
      let!(:wine2) { Wine.create(name: "Cheval Rouge", producer: "Saint-Emilion", year: 1983, price: 100) }
      let!(:wine3) { Wine.create(name: "Cheval Bleu", producer: "Saint-Emilion", year: 1983, price: 10) }

      it 'should return status code 200' do
        get '/api/wines?price_low=50&price_high=100'

        expect(response).to have_http_status(200)
      end

      it 'should return only wines included in range' do
        get '/api/wines?price_low=50&price_high=100'
        res = [
          {
              "id": wine2.id,
              "name": "Cheval Rouge",
              "producer": "Saint-Emilion",
              "year": 1983,
              "evaluation": nil,
              "price": 100
          }
        ]

        expect(response.body).not_to be_empty
        expect(JSON.parse(response.body)).to eq(res.as_json)
      end
    end
  end
end
