class BookController < ApplicationController
  def all
    @books = Book.all()
  end
  def create
    Book.new({"name"=>params[:books][:name],"author"=>params[:books][:author]})
    redirect_to action: :all
  end
  def new
  end
  def view
      @book = Book.find(params[:name])
      puts @book
  end
end
