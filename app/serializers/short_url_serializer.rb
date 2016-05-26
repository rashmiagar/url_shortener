class ShortUrlSerializer < ActiveModel::Serializer
  attributes :id, :long_url, :shorty, :visits_count
end
