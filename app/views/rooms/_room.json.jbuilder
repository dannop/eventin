json.extract! room, :id, :availability, :vacancies, :number, :created_at, :updated_at
json.url room_url(room, format: :json)
