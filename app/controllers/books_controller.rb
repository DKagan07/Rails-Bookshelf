class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @books = Book.new
  end

  def show
    @books = Book.find(params[:id])
  end

end
