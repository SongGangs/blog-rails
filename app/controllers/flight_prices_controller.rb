class FlightPricesController < ApplicationController
  before_action :set_flight_price, only: [:show, :edit, :update, :destroy]

  # GET /flight_prices
  # GET /flight_prices.json
  def index
    @flight_prices = FlightPrice.all
  end

  # GET /flight_prices/1
  # GET /flight_prices/1.json
  def show
  end

  # GET /flight_prices/new
  def new
    @flight_price = FlightPrice.new
  end

  # GET /flight_prices/1/edit
  def edit
  end

  # POST /flight_prices
  # POST /flight_prices.json
  def create
    @flight_price = FlightPrice.new(flight_price_params)
    # binding.pry
    respond_to do |format|
      if @flight_price.save
        format.html { redirect_to @flight_price, notice: 'Flight price was successfully created.' }
        format.json { render :show, status: :created, location: @flight_price }
      else
        format.html { render :new }
        format.json { render json: @flight_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flight_prices/1
  # PATCH/PUT /flight_prices/1.json
  def update
    respond_to do |format|
      if @flight_price.update(flight_price_params)
        format.html { redirect_to @flight_price, notice: 'Flight price was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight_price }
      else
        format.html { render :edit }
        format.json { render json: @flight_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_prices/1
  # DELETE /flight_prices/1.json
  def destroy
    @flight_price.destroy
    respond_to do |format|
      format.html { redirect_to flight_prices_url, notice: 'Flight price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight_price
      @flight_price = FlightPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_price_params
      params.require(:flight_price).permit(:weekdays_regular, :weekdays_reward, :weekends_regular, :weekends_reward, :flight_code)
    end
end
