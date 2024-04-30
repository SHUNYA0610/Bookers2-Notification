class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy] 
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(book)
    else
      redirect_to book_path(book)
    end
  end

  def destroy
    comment = BookComment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  def ensure_correct_user
    book_comment = BookComment.find(params[:id])
    unless book_comment.user_id == current_user.id
    redirect_back(fallback_location: root_path)
    end
  end
  
end