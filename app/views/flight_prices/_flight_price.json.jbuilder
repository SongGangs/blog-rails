json.extract! flight_price, :id, :weekdays_regular, :weekdays_reward, :weekends_regular, :weekends_reward, :flight_code, :created_at, :updated_at
json.url flight_price_url(flight_price, format: :json)
