class MigrateDbToItemQuantity < ActiveRecord::Migration
  def up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity) #собираем продукты и считаем сколько каких.
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete.all
          item = cart.line_items.build(product_id: product_id)
          item.quantity =  quantity
          item.save!
        end
      end
    end
  end


  def down
    cart.line_items.where(quantity>1).each do |item|
      item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end
    end
  end
end
