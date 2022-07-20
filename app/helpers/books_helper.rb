module BooksHelper
  def search
    search_text = params[:search_text]
    @books = if search_text.blank?
                  Book.all
                else
                  Book.search(search_text)
                end
    render :home
  end

  def current_book
    @current_book ||= Book.find_by(id: book_id)
  end
end
