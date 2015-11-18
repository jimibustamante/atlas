require 'test_helper'

class MiningWastesControllerTest < ActionController::TestCase
  setup do
    @mining_waste = mining_wastes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mining_wastes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mining_waste" do
    assert_difference('MiningWaste.count') do
      post :create, mining_waste: {  }
    end

    assert_redirected_to mining_waste_path(assigns(:mining_waste))
  end

  test "should show mining_waste" do
    get :show, id: @mining_waste
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mining_waste
    assert_response :success
  end

  test "should update mining_waste" do
    patch :update, id: @mining_waste, mining_waste: {  }
    assert_redirected_to mining_waste_path(assigns(:mining_waste))
  end

  test "should destroy mining_waste" do
    assert_difference('MiningWaste.count', -1) do
      delete :destroy, id: @mining_waste
    end

    assert_redirected_to mining_wastes_path
  end
end
