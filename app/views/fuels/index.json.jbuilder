json.array!(@fuels) do |fuel|
  json.extract! fuel, :id, :code, :description
  json.url fuel_url(fuel, format: :json)
end
