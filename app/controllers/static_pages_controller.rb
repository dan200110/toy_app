class StaticPagesController < ApplicationController
  # before_action :load_cart

  def home
    @books = Book.all.latest_book
  end

  def help; end

  def contact; end

  private
  def price_desc
    @books = Book.all.price_desc
  end
end
