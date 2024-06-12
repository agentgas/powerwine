class Expert < ApplicationRecord
    validates :email, presence: true, uniqueness: true

    has_many :rates
end
