require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products( :ruby ).id
    end

    assert_redirected_to store_url
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    cart = carts(:cart_with_ruby)
    session[:cart_id] = carts(:cart_with_ruby).id
    assert_equal 1, cart.line_items.count, "cart_with_ruby has more or less line items than one."
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: cart.line_items.first
    end
    assert_redirected_to store_path
    assert_equal 0, cart.line_items.count
  end

  test "should add line items with AJAX" do
    assert_difference("LineItem.count", +1) do
      xhr :post, :create, product_id: products(:ruby).id
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end
  end

=begin  test "should remove line items with  AJAX" do #Не работает. Возможно из-за того, что в самом методе тоже не определялась текущая cart без ручного присваивания.
      assert_difference("LineItem.count", -1) do
      xhr :post, :destroy, id: line_items(:delete_line).id
    end
  end
=end
end
