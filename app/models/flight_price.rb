class FlightPrice
  include Mongoid::Document
  require 'date'
  belongs_to :flight, :class_name => 'Flight', optional: true

  field :weekdays_regular, type: String
  field :weekdays_reward, type: String
  field :weekends_regular, type: String
  field :weekends_reward, type: String
  field :flight_code, type: String

  def find_by_combine(type, date, codes)
    my_field = convert_params(type, date)
    flight = FlightPrice.in(flight_code: codes).order_by("#{my_field}": :asc).first
    price = flight["#{my_field}"]
    flights = FlightPrice.where("#{my_field}": price).in(flight_code: codes)
    {
      price: price,
      flights: flights
    }
  end

  def find_by_code(code)
    FlightPrice.find_by("flight_code": code)
  end

  private

  def convert_params(type, date)
    wday = Date.strptime(date, '%Y%m%d').wday
    is_workday = (1..5).include?(wday)
    if type == 'reward' && is_workday
      my_field = 'weekdays_reward'
    elsif type == 'regular' && is_workday
      my_field = 'weekdays_regular'
    elsif type == 'reward' && !is_workday
      my_field = 'weekends_reward'
    elsif type == 'regular' && !is_workday
      my_field = 'weekends_regular'
    end
    my_field
  end
end
