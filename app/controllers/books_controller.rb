class BooksController < ApplicationController
  def new
    @book = new
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
    @book_user = User.find(@book.user_id)
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
     redirect_to books_path
    end

  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      @user = current_user
      @books = Book.all
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
