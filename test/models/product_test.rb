require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  def new_product(title: "My Book Title", description: "yyy", price: 1, image_url:   "image_url.jpg")
    Product.new(title:       title,
                description: description,
                price:       price,
                image_url:   image_url)
  end

  test "product price must be positive" do
    product = new_product(price: -1)
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
  end

  test "product price must higher than 0.01" do
    product = new_product(price: 0)
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
  end

  test "valid product price test" do
    product = new_product(price: 1)
    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |url|
      assert new_product(image_url: url).valid?, "#{url} should be valid"
    end

    bad.each do |url|
      assert new_product(image_url: url).invalid?, "#{url} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = new_product(title: products(:ruby).title)
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
     product = new_product(title: products(:ruby).title)
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end

  test "minimum 10 symbols in title" do
    product = new_product(title: "ABC")
    assert product.invalid?
    assert_equal ["10 characters is the minimum allowed"], product.errors[:title]
  end

  test "product update" do
    products(:ruby).title = "New title"
    assert_equal [products(:ruby).title], ["New title"], "Product was not updated!"
  end

  test "product deletion" do
    products(:ruby).delete
    assert products(:ruby).id?
  end
end
