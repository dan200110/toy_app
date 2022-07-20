class StaticPagesController < ApplicationController

  def home
    @books = Book.search(params[:search])
  end

  def help; end

  def contact; end

  private
  def price_desc
    @books = Book.search(params[:search])
  end
end
