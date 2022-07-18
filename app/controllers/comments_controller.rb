class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.image.attach(params[:comment][:image])
    if @comment.save
    flash[:success] = "Comment created!"
    redirect_to root_path
    else
      flash[:danger] = "Fail created!"
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :num_star, :book_id, :image)
  end
end
