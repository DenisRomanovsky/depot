class CopyPriceToLineItem < ActiveRecord::Migration
  def change
     add_column :line_items, :price, :integer
  end

  def up
    line_items.each do |item|
      item.price = item.product.price
    end
  end
end
