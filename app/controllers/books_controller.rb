class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @books = Book.all
  end

  def show
    @books = Book.find(params[:id])
  end

  def edit
    @books = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    #@books = Book.new
    @books = current_user.books.build
  end

  def create
    #@books = Book.new(book_params)
    @books = current_user.books.build(book_params)
    if @books.save
      redirect_to @books
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to root_path, status: :see_other 
  end

  def correct_user
    @book = current_user.books.find_by(id: params[:id])

    redirect_to root_path, notice: "Not Authorized to Edit this Book" if @book.nil?
  end


  private
    def book_params
      params.require(:book).permit(:title, :author, :read, :synopsis, :user_id)
    end

end
