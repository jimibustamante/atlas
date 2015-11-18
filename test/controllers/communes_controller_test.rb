require 'test_helper'

class CommunesControllerTest < ActionController::TestCase
  setup do
    @commune = communes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:communes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commune" do
    assert_difference('Commune.count') do
      post :create, commune: {  }
    end

    assert_redirected_to commune_path(assigns(:commune))
  end

  test "should show commune" do
    get :show, id: @commune
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commune
    assert_response :success
  end

  test "should update commune" do
    patch :update, id: @commune, commune: {  }
    assert_redirected_to commune_path(assigns(:commune))
  end

  test "should destroy commune" do
    assert_difference('Commune.count', -1) do
      delete :destroy, id: @commune
    end

    assert_redirected_to communes_path
  end
end
