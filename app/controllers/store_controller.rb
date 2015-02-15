class StoreController < ApplicationController
  def index
    @products = Product.order(:title)

    session[:show_store_counter] ? session[:show_store_counter] += 1 : session[:show_store_counter] = 1

    #@show_store_counter = session[:show_store_counter]

  end
end
