require 'test_helper'

class WorkStaffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_staff = work_staffs(:one)
  end

  test "should get index" do
    get work_staffs_url
    assert_response :success
  end

  test "should get new" do
    get new_work_staff_url
    assert_response :success
  end

  test "should create work_staff" do
    assert_difference('WorkStaff.count') do
      post work_staffs_url, params: { work_staff: { staff_id: @work_staff.staff_id, workshop_id: @work_staff.workshop_id } }
    end

    assert_redirected_to work_staff_url(WorkStaff.last)
  end

  test "should show work_staff" do
    get work_staff_url(@work_staff)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_staff_url(@work_staff)
    assert_response :success
  end

  test "should update work_staff" do
    patch work_staff_url(@work_staff), params: { work_staff: { staff_id: @work_staff.staff_id, workshop_id: @work_staff.workshop_id } }
    assert_redirected_to work_staff_url(@work_staff)
  end

  test "should destroy work_staff" do
    assert_difference('WorkStaff.count', -1) do
      delete work_staff_url(@work_staff)
    end

    assert_redirected_to work_staffs_url
  end
end
