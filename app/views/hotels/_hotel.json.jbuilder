json.extract! hotel, :id, :name, :address, :description, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
