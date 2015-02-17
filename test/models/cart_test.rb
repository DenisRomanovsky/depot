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
    cart = new_cart_with_one_product(:two)
    # Re-add the same product
    cart.add_product(products(:two).id).save
    assert_equal 1, cart.line_items.count, "Extra line item has appeared"
    line = cart.line_items.first
    assert_equal 2, line.quantity, "Wrong quantity of goods for a line-item"
  end

 test "cart line item should save price" do
    cart = carts(:cart1)
      product = products(:ruby)
      item = cart.add_product product.id
      old_price = product.price
      product.price = 0
      assert_equal item.price, old_price,
        "cart line item did not save price"
  end

  test "cart should be created and destroyed" do
    assert_difference('Cart.count', +1) do
      Cart.create
    end
    cart = Cart.create
    assert_difference('Cart.count', -1) do
      cart.destroy #Работает, но нет проверки сессии. Скорее всего, неправильно.
    end
  end
end
