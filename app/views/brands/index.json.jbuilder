json.array!(@brands) do |brand|
  json.extract! brand, :id, :code, :description
  json.url brand_url(brand, format: :json)
end
