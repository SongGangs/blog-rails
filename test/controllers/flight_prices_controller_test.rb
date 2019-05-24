require 'test_helper'

class FlightPricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flight_price = flight_prices(:one)
  end

  test "should get index" do
    get flight_prices_url
    assert_response :success
  end

  test "should get new" do
    get new_flight_price_url
    assert_response :success
  end

  test "should create flight_price" do
    assert_difference('FlightPrice.count') do
      post flight_prices_url, params: { flight_price: { fight_code: @flight_price.fight_code, weekdays_regular: @flight_price.weekdays_regular, weekdays_reward: @flight_price.weekdays_reward, weekends_regular: @flight_price.weekends_regular, weekends_reward: @flight_price.weekends_reward } }
    end

    assert_redirected_to flight_price_url(FlightPrice.last)
  end

  test "should show flight_price" do
    get flight_price_url(@flight_price)
    assert_response :success
  end

  test "should get edit" do
    get edit_flight_price_url(@flight_price)
    assert_response :success
  end

  test "should update flight_price" do
    patch flight_price_url(@flight_price), params: { flight_price: { fight_code: @flight_price.fight_code, weekdays_regular: @flight_price.weekdays_regular, weekdays_reward: @flight_price.weekdays_reward, weekends_regular: @flight_price.weekends_regular, weekends_reward: @flight_price.weekends_reward } }
    assert_redirected_to flight_price_url(@flight_price)
  end

  test "should destroy flight_price" do
    assert_difference('FlightPrice.count', -1) do
      delete flight_price_url(@flight_price)
    end

    assert_redirected_to flight_prices_url
  end
end
