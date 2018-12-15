json.extract! user, :id, :name, :email, :password_digest, :cpf, :password_confirmation, :birth, :gender, :pament_type, :payment_status, :ej_id, :room_id, :profile_photo, :created_at, :updated_at
json.url user_url(user, format: :json)
