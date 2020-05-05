class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:update,:edit]

  def show
    @book = Book.find(params[:id])
    @user= User.new(@current_user)
    @booknew=Book.new
    @comment=BookComment.new
  end

  def index
    @books = Book.all 
    @booknew=Book.new
  end

  def create
    @booknew = Book.new(book_params) 
    @booknew.user_id=current_user.id
    if @booknew.save 
      redirect_to @booknew, notice: "You have creatad book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

  def baria_user
    unless Book.find(params[:id]).user_id == current_user.id
      redirect_to books_path
    end
   end

end