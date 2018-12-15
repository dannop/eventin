require 'test_helper'

class EJsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ej = ejs(:one)
  end

  test "should get index" do
    get ejs_url
    assert_response :success
  end

  test "should get new" do
    get new_ej_url
    assert_response :success
  end

  test "should create ej" do
    assert_difference('Ej.count') do
      post ejs_url, params: { ej: { college: @ej.college, federation_id: @ej.federation_id, name: @ej.name } }
    end

    assert_redirected_to ej_url(Ej.last)
  end

  test "should show ej" do
    get ej_url(@ej)
    assert_response :success
  end

  test "should get edit" do
    get edit_ej_url(@ej)
    assert_response :success
  end

  test "should update ej" do
    patch ej_url(@ej), params: { ej: { college: @ej.college, federation_id: @ej.federation_id, name: @ej.name } }
    assert_redirected_to ej_url(@ej)
  end

  test "should destroy ej" do
    assert_difference('Ej.count', -1) do
      delete ej_url(@ej)
    end

    assert_redirected_to ejs_url
  end
end
