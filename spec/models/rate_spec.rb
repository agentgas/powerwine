require 'rails_helper'

RSpec.describe Rate, type: :model do
  before(:all) do
    Wine.delete_all
    Expert.delete_all

    @wine = Wine.create(name: "Cheval Blanc", producer: "Saint-Emilion", year: 1983, price: 1500)
    @expert = Expert.create(name: "Karl", email: "karl.rspec@powerwine.com")
  end

  context "when a commit is done" do
    context "when a Rate is created" do
      let!(:rate) { @wine.rates.create(rate: 10, wine_id: @wine.id, expert_id: @expert.id) }

      it "updates Wine related Evaluation" do

        expect(@wine.evaluation).to eq 10
      end
    end

    context "when a Rate is updated" do
      let(:rate) { @wine.rates.create(rate: 10, wine_id: @wine.id, expert_id: @expert.id) }

      it "updates Wine related Evaluation" do
        rate.update(rate: 2)

        expect(@wine.evaluation).to eq 2
      end
    end

    context "when a Rate is deleted" do
      let!(:rate) { @wine.rates.create(rate: 8, wine_id: @wine.id, expert_id: @expert.id) }

      it "updates Wine related Evaluation" do
        expect(@wine.evaluation).to eq 8

        rate.destroy

        expect(@wine.evaluation).to be_nan
      end
    end
  end
end
