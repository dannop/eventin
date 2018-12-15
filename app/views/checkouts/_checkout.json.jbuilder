json.extract! checkout, :id, :ticket_id, :lot_id, :price, :status, :buyer_name, :reference, :created_at, :updated_at
json.url checkout_url(checkout, format: :json)
