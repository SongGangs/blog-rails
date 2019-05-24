require "application_system_test_case"

class FlightPricesTest < ApplicationSystemTestCase
  setup do
    @flight_price = flight_prices(:one)
  end

  test "visiting the index" do
    visit flight_prices_url
    assert_selector "h1", text: "Flight Prices"
  end

  test "creating a Flight price" do
    visit flight_prices_url
    click_on "New Flight Price"

    fill_in "Flight code", with: @flight_price.flight_code
    fill_in "Weekdays regular", with: @flight_price.weekdays_regular
    fill_in "Weekdays reward", with: @flight_price.weekdays_reward
    fill_in "Weekends regular", with: @flight_price.weekends_regular
    fill_in "Weekends reward", with: @flight_price.weekends_reward
    click_on "Create Flight price"

    assert_text "Flight price was successfully created"
    click_on "Back"
  end

  test "updating a Flight price" do
    visit flight_prices_url
    click_on "Edit", match: :first

    fill_in "Flight code", with: @flight_price.flight_code
    fill_in "Weekdays regular", with: @flight_price.weekdays_regular
    fill_in "Weekdays reward", with: @flight_price.weekdays_reward
    fill_in "Weekends regular", with: @flight_price.weekends_regular
    fill_in "Weekends reward", with: @flight_price.weekends_reward
    click_on "Update Flight price"

    assert_text "Flight price was successfully updated"
    click_on "Back"
  end

  test "destroying a Flight price" do
    visit flight_prices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Flight price was successfully destroyed"
  end
end
