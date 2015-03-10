class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = ["Check", "Credit Card", "Cash"]

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id
      line_items << item #Автоматом добавляет ключи текущего ордера ко всем лайн-айтемам. Крутотенюшка!
    end
  end

end
