json.array!(@vehicle_types) do |vehicle_type|
  json.extract! vehicle_type, :id, :name, :description
  json.url vehicle_type_url(vehicle_type, format: :json)
end
