require 'net/http'
require 'rubygems'
require 'json'

class Book
  def self.all()
    return JSON.parse(Net::HTTP.get_response(URI('http://localhost:5000/book/')).body)["data"]
  end
  def self.new(book)
    req = Net::HTTP::Post.new('/book', initheader = {'Content-Type' =>'application/json'})
    req.body = book.to_json
    response = Net::HTTP.new("localhost", 5000).start {|http| http.request(req) }
  end
  def self.find(name)
    return JSON.parse(Net::HTTP.get_response(URI('http://localhost:5000/book/'+name.gsub(' ','%20'))).body)["data"][0]
  end
end
