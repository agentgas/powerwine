class RateSerializer < ActiveModel::Serializer
  attributes :id, :rate, :wine_id, :expert_id
end
