class Rate < ApplicationRecord
    belongs_to :wine
    belongs_to :expert

    after_commit :update_wine_evaluation

    private

    def update_wine_evaluation
        wine = self.wine

        rates_count = wine.rates.count.to_f
        total_rates = wine.rates.sum(:rate).to_f
        
        self.wine.update(evaluation: (total_rates / rates_count).to_f.round(1))
    end
end
