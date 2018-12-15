json.extract! event, :id, :name, :calendar, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
