require 'test_helper'

class CartTest < ActiveSupport::TestCase

def new_cart_with_one_product(product_name)
    cart = Cart.create
    cart.add_product(products(product_name).id)
    cart.save
    cart
  end

  test 'cart should create a new line item when adding a new product' do
    cart = new_cart_with_one_product(:one)
    assert_equal 1, cart.line_items.count
    # Add a new product
    cart.add_product(products(:ruby).id)
    cart.save #Надо переделать с моками(?) или через фикстуры корзин, чтобы не создавать карт в тесте.
    assert_equal 2, cart.line_items.count
  end

  test 'cart should update an existing line item when adding an existing product' do
    cart = new_cart_with_one_product(:one)
    # Re-add the same product
    cart.add_product(products(:one).id)
    assert_equal 1, cart.line_items.count
  end

 test "cart line item should save price" do
    cart = carts(:cart1)
      product = products(:ruby)
      item = cart.add_product product.id
      puts item.price.class
      puts product.price.class
      assert_equal item.price, product.price,
        "cart line item did not save price"
  end

  test "cart should be created and destroyed" do
    assert_same Cart.count, Cart.destroy_all.count,
      "unable to destroy existing carts"
    Cart.create
    assert_equal 1, Cart.count, "unable to create cart"
    assert_equal 1, Cart.destroy_all.count, "unable to destroy cart"
  end
end
