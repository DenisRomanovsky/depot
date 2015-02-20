class Cart < ActiveRecord::Base
  has_many :line_items

  def add_product (product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
      current_item
    else
      current_item = line_items.build(product_id: product_id)
      current_item.price = Product.find_by_id(product_id).price
      current_item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def decrement_line_item_quantity(line_item_id)
    current_item = line_items.find(line_item_id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end

end
