module CurrentCart
  extend ActiveSupport::Concern

  private

#Session method for Carts.

  def set_cart

    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create

    session[:cart_id] = @cart.id
    session[:show_store_counter] = 0
  end
end
