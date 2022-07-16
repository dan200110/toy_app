class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper
  before_action :init_cart
  before_action :load_products

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def load_products
    @products = Book.by_ids @carts.keys
  end
end
