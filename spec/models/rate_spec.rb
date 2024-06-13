require 'rails_helper'

RSpec.describe Rate, type: :model do
  before(:all) do
    Wine.delete_all
    Expert.delete_all

    @wine = Wine.create(name: "Cheval Blanc", producer: "Saint-Emilion", year: 1983, price: 1500)
    @expert = Expert.create(name: "Karl", email: "karl.rspec@powerwine.com")
    @expert2 = Expert.create(name: "John", email: "john.rspec@powerwine.com")
  end

  context "when a commit is done" do
    context "when a Rate is created" do
      let!(:rate) { @wine.rates.create(rate: 10, wine_id: @wine.id, expert_id: @expert.id) }

      it "updates Wine related Evaluation" do
        expect(@wine.evaluation).to eq 10
      end

      context "when a second rate is created on same wine by same expert" do
        let!(:rate) { @wine.rates.create(rate: 8, wine_id: @wine.id, expert_id: @expert2.id) }
        it "to raise an ActiveRecord RecordInvalid error" do
          expect { @wine.rates.create!(rate: 10, wine_id: @wine.id, expert_id: @expert2.id) }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context "when a second Rate is created on same wine by a different expert" do
        let!(:rate2) { @wine.rates.create(rate: 8, wine_id: @wine.id, expert_id: @expert2.id) }

        it "updates Wine related Evaluation" do
          expect(@wine.evaluation).to eq 9
        end
      end
    end

    context "when a Rate is updated" do
      let(:rate) { @wine.rates.create(rate: 10, wine_id: @wine.id, expert_id: @expert.id) }

      it "updates Wine related Evaluation" do
        rate.update(rate: 2)

        expect(@wine.evaluation).to eq 2
      end
    end

    context "when rates are deleted" do
      let!(:rate) { @wine.rates.create(rate: 8, wine_id: @wine.id, expert_id: @expert.id) }
      let!(:rate2) { @wine.rates.create(rate: 9, wine_id: @wine.id, expert_id: @expert2.id) }

      it "updates Wine related Evaluation" do
        expect(@wine.evaluation).to eq 8.5

        rate.destroy

        expect(@wine.evaluation).to eq 9

        rate2.destroy

        expect(@wine.evaluation).to be_nan
      end
    end
  end
end
