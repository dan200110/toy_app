class CartsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :create]
  before_action :current_carts, except: [:show, :new, :edit]
  before_action :load_book, only: [:create, :update]
  before_action :load_books, only: :index
  before_action :init_cart

  def index; end

  def create
    if check_quantily
      add_item @book, @quantily
    else
      flash[:danger] = t ".danger_quantily"
    end
    redirect_to carts_path
  end

  def update
    if @carts.key? params[:id]
      if check_quantily
        @carts[params[:id]] = @quantily
        session["cart_#{user_id}"] = @carts
        flash[:success] = t ".success_update"
      else
        flash[:danger] = t ".danger_quantily"
      end
    else
      flash[:danger] = t ".danger_update"
    end
    redirect_to carts_path
  end

  def destroy
    if @carts.key? params[:id]
      @carts.delete params[:id]
      flash[:success] = t ".success_delete"
      session[:carts] = @carts
    else
      flash[:danger] = t ".danger_delete"
    end
    redirect_to carts_path
  end

  private

  def load_books
    @books = Book.by_ids @carts.keys
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger_book"
    redirect_to carts_path
  end

  def check_quantily
    @quantily = params[:quantily].to_i
    @quantily <= 50 && @quantily > 0
  end

  def add_item book, quantily
    if @carts.key? book.id.to_s
      flash[:info] = t ".info_book"
    else
      @carts[book.id.to_s] = quantily
      user_id = session[:user_id]
      session["cart_#{user_id}"] = @carts
      flash[:success] = t ".success_add"
    end
  end
end
