class Wine < ApplicationRecord
    has_many :rates, dependent: :destroy
end
