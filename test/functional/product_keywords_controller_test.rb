require 'test_helper'

class ProductKeywordsControllerTest < ActionController::TestCase
  setup do
    @product_keyword = product_keywords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_keywords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_keyword" do
    assert_difference('ProductKeyword.count') do
      post :create, product_keyword: { keyword_id: @product_keyword.keyword_id, product_id: @product_keyword.product_id }
    end

    assert_redirected_to product_keyword_path(assigns(:product_keyword))
  end

  test "should show product_keyword" do
    get :show, id: @product_keyword
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_keyword
    assert_response :success
  end

  test "should update product_keyword" do
    put :update, id: @product_keyword, product_keyword: { keyword_id: @product_keyword.keyword_id, product_id: @product_keyword.product_id }
    assert_redirected_to product_keyword_path(assigns(:product_keyword))
  end

  test "should destroy product_keyword" do
    assert_difference('ProductKeyword.count', -1) do
      delete :destroy, id: @product_keyword
    end

    assert_redirected_to product_keywords_path
  end
end
