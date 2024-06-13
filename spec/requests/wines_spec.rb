require 'rails_helper'

RSpec.describe "Wines", type: :request do
  before(:all) do
    Wine.delete_all
  end

  describe 'GET /api/wines' do
    context "when there is wines" do
      let!(:wine1) { Wine.create(name: "Cheval Vert", producer: "Saint-Emilion", year: 1983, price: 150) }
      let!(:wine2) { Wine.create(name: "Cheval Rouge", producer: "Saint-Emilion", year: 1983, price: 100) }
      it 'should return wines' do
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
  
      it 'should return status code 200' do
        get '/api/wines'

        expect(response).to have_http_status(200)
      end
    end
  end
end
