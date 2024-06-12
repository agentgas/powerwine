class WineSerializer < ActiveModel::Serializer
  attributes :id, :name, :producer, :year, :evaluation, :price
end
