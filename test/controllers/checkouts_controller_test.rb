require 'test_helper'

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checkout = checkouts(:one)
  end

  test "should get index" do
    get checkouts_url
    assert_response :success
  end

  test "should get new" do
    get new_checkout_url
    assert_response :success
  end

  test "should create checkout" do
    assert_difference('Checkout.count') do
      post checkouts_url, params: { checkout: { buyer_name: @checkout.buyer_name, lot_id: @checkout.lot_id, price: @checkout.price, reference: @checkout.reference, status: @checkout.status, ticket_id: @checkout.ticket_id } }
    end

    assert_redirected_to checkout_url(Checkout.last)
  end

  test "should show checkout" do
    get checkout_url(@checkout)
    assert_response :success
  end

  test "should get edit" do
    get edit_checkout_url(@checkout)
    assert_response :success
  end

  test "should update checkout" do
    patch checkout_url(@checkout), params: { checkout: { buyer_name: @checkout.buyer_name, lot_id: @checkout.lot_id, price: @checkout.price, reference: @checkout.reference, status: @checkout.status, ticket_id: @checkout.ticket_id } }
    assert_redirected_to checkout_url(@checkout)
  end

  test "should destroy checkout" do
    assert_difference('Checkout.count', -1) do
      delete checkout_url(@checkout)
    end

    assert_redirected_to checkouts_url
  end
end
