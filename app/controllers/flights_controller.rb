class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  def search
    print params[:date]
    flight = Flight.new
    # from chnegdu  to xi'an
    from_flights = flight.find_by_where('Chengdu', 'Xi\'an')
    # flight codes
    codes = from_flights.map(&:flight_code)
    # map(&:) 可以替代 each
    # codes = []
    # from_flights.each do |f|
    #   codes << f.flight_code
    # end
    flight_price = FlightPrice.new
    # min price and detail
    from_combine = flight_price.find_by_combine(params[:type], params[:date], codes)
    from_flight_price = from_combine[:flights]
    codes = from_flight_price.map(&:flight_code)
    # codes = []
    # from_flight_price.each do |f|
    #   codes << f.flight_code
    # end
    # detail flights
    from_flights = flight.in_code(codes)

    # from xi'an to chengdu 
    to_flights = flight.find_by_where('Xi\'an', 'Chengdu')
    codes = to_flights.map(&:flight_code)
    # codes = []
    # to_flights.each do |f|
    #   codes << f.flight_code
    # end
    to_combine = flight_price.find_by_combine(params[:type], params[:date], codes)
    to_flight_price = to_combine[:flights]
    codes = to_flight_price.map(&:flight_code)
    # codes = []
    # to_flight_price.each do |f|
    #   codes << f.flight_code
    # end
    to_flights = flight.in_code(codes)
    {
      from_price: from_combine[:price],
      from_flights: from_flights,
      to_price: to_combine[:price],
      to_flights: to_flights
    }
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
      # @flight_price = FlightPrice.where("flight_code": @flight.flight_code)
      @flight_price = FlightPrice.new
      @flight_price = @flight_price.find_by_code(@flight.flight_code)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.require(:flight).permit(:flight_code, :sched, :from, :to)
    end
end