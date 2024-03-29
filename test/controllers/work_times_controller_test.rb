require "test_helper"

class WorkTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_time = work_times(:one)
  end

  test "should get index" do
    get work_times_url
    assert_response :success
  end

  test "should get new" do
    get new_work_time_url
    assert_response :success
  end

  test "should create work_time" do
    assert_difference("WorkTime.count") do
      post work_times_url, params: { work_time: { content: @work_time.content, deleted: @work_time.deleted, globalWorkTimeId: @work_time.globalWorkTimeId, minutes: @work_time.minutes } }
    end

    assert_redirected_to work_time_url(WorkTime.last)
  end

  test "should show work_time" do
    get work_time_url(@work_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_time_url(@work_time)
    assert_response :success
  end

  test "should update work_time" do
    patch work_time_url(@work_time), params: { work_time: { content: @work_time.content, deleted: @work_time.deleted, globalWorkTimeId: @work_time.globalWorkTimeId, minutes: @work_time.minutes } }
    assert_redirected_to work_time_url(@work_time)
  end

  test "should destroy work_time" do
    assert_difference("WorkTime.count", -1) do
      delete work_time_url(@work_time)
    end

    assert_redirected_to work_times_url
  end
end
