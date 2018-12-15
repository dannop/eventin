json.extract! lecture, :id, :calendar, :availability, :vacancies, :description, :event_id, :created_at, :updated_at
json.url lecture_url(lecture, format: :json)
