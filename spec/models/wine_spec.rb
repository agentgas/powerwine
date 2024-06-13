require 'rails_helper'

RSpec.describe Wine, type: :model do
  context "when there is no rate" do
    let!(:wine) { Wine.create(name: "Cheval Blanc", producer: "Saint-Emilion", year: 1983, price: 1500) }
    
    it "does not have an evalutation" do
      expect(wine.evaluation).to be_nil
    end
  end
end
