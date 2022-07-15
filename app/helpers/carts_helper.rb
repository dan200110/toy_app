module CartsHelper
  def amount_book quantity, price
    quantity * price
  end

  def total_price
    books = Book.by_ids current_carts.keys
    books.reduce(0) do |total, book|
      total + book.price * @carts[book.id.to_s].to_i
    end
  end

  def total_price_book id
    if book = Book.find_by(id: id)
      number_to_currency (current_carts[id.to_s].to_i * book.price),
        locale: :en
    else
      flash[:danger] = I18n.t ".carts.danger_book"
      redirect_to carts_path
    end
  end

  def count_carts
    count = 0
    if current_carts.present?
      current_carts.each do |_key, value|
        count += value.to_i
      end
    end
    count
  end

  def current_carts
    user_id = session[:user_id]
    session["cart_#{user_id}"] ||= {}
    clean_carts
    @carts = session["cart_#{user_id}"] ||= {}
  end

  def check_carts
    return if current_carts.present?
    flash[:danger] = I18n.t ".carts.carts_empty"
    redirect_to carts_path
  end

  def clear_carts
    session.delete :carts
  end

  def clean_carts
    user_id = session[:user_id]
    return unless session["cart_#{user_id}"] ||= {}.present?
    session["cart_#{user_id}"] ||= {}.each do |key, _value|
      session["cart_#{user_id}"] ||= {}.delete key unless Book.find_by id: key
    end
  end

  def init_cart
    user_id = session[:user_id]
    session["cart_#{user_id}"] ||= {}
    @carts = session["cart_#{user_id}"]
  end
end
