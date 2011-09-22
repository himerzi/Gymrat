require 'test_helper'

class ClimbingCentresControllerTest < ActionController::TestCase
  setup do
    @climbing_centre = climbing_centres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:climbing_centres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create climbing_centre" do
    assert_difference('ClimbingCentre.count') do
      post :create, climbing_centre: @climbing_centre.attributes
    end

    assert_redirected_to climbing_centre_path(assigns(:climbing_centre))
  end

  test "should show climbing_centre" do
    get :show, id: @climbing_centre.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @climbing_centre.to_param
    assert_response :success
  end

  test "should update climbing_centre" do
    put :update, id: @climbing_centre.to_param, climbing_centre: @climbing_centre.attributes
    assert_redirected_to climbing_centre_path(assigns(:climbing_centre))
  end

  test "should destroy climbing_centre" do
    assert_difference('ClimbingCentre.count', -1) do
      delete :destroy, id: @climbing_centre.to_param
    end

    assert_redirected_to climbing_centres_path
  end
end
