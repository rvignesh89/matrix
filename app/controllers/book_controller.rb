require 'date'

class BookController < ApplicationController
  def all
    @books = Book.all()
    @books.sort! {|x,y| x['name'] <=> y['name']}
  end
  def create
    Book.new({
      "code"=>params[:books][:code],
      "name"=>params[:books][:name],
      "author"=>params[:books][:author]
      })
    redirect_to action: :all
  end
  def new
  end
  def view
      @book = Book.find(params[:name])
  end
  def loan
      Book.update(params[:name],{"status"=>"Loaned","loan"=>{"to"=>params[:loanee],"on"=>DateTime.now.to_s,"due"=>(DateTime.now + 30).to_s}})
      redirect_to :back
  end
  def return
    Book.update(params[:name],{"status"=>"Available","loan"=>{}})
    redirect_to :back
  end
end
