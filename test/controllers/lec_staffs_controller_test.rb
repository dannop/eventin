require 'test_helper'

class LecStaffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lec_staff = lec_staffs(:one)
  end

  test "should get index" do
    get lec_staffs_url
    assert_response :success
  end

  test "should get new" do
    get new_lec_staff_url
    assert_response :success
  end

  test "should create lec_staff" do
    assert_difference('LecStaff.count') do
      post lec_staffs_url, params: { lec_staff: { lecture_id: @lec_staff.lecture_id, staff_id: @lec_staff.staff_id } }
    end

    assert_redirected_to lec_staff_url(LecStaff.last)
  end

  test "should show lec_staff" do
    get lec_staff_url(@lec_staff)
    assert_response :success
  end

  test "should get edit" do
    get edit_lec_staff_url(@lec_staff)
    assert_response :success
  end

  test "should update lec_staff" do
    patch lec_staff_url(@lec_staff), params: { lec_staff: { lecture_id: @lec_staff.lecture_id, staff_id: @lec_staff.staff_id } }
    assert_redirected_to lec_staff_url(@lec_staff)
  end

  test "should destroy lec_staff" do
    assert_difference('LecStaff.count', -1) do
      delete lec_staff_url(@lec_staff)
    end

    assert_redirected_to lec_staffs_url
  end
end
