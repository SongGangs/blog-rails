class Flight
  include Mongoid::Document

  has_one :flight_price

  field :flight_code, type: String
  field :sched, type: String
  field :from, type: String
  field :to, type: String

  def find_by_where(from, to)
    Flight.where(from: from, "to": to)
  end

  def in_code(codes)
    Flight.in(flight_code: codes)
    # flight = Flight.in("flight_code": codes).order_by("sched")
    # binding.pry
  end

  private

  def find_by_code(code)
    Flight.find_by(flight_code: code)
  end
end
