class BooksController < ApplicationController
  def index; end
  def show
    @book = Book.find(params[:id])
    @comment = current_user.comments.build if logged_in?
    @comments = Comment.by_book_id(params[:id])
                       .latest_comment
                       .includes(:user)
    render :show
  end


end
