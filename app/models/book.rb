require 'net/http'
require 'rubygems'
require 'json'

class Book
  @@api_url = ENV['API_URL'] + 'book/'
  @@api_host = ENV['API_HOST']
  @@api_port = ENV['API_PORT']
  def self.all()
    puts @@api_url
    return JSON.parse(Net::HTTP.get_response(URI(@@api_url)).body)["data"]
  end
  def self.new(book)
    req = Net::HTTP::Post.new('/book', initheader = {'Content-Type' =>'application/json'})
    book[:status] = 'Available'
    req.body = book.to_json
    response = Net::HTTP.new(@@api_host, @@api_port).start {|http| http.request(req) }
  end
  def self.find(name)
    return JSON.parse(Net::HTTP.get_response(URI(@@api_url+name.gsub(' ','%20'))).body)["data"][0]
  end
  def self.update(name,updatedBook)
    path = '/book/'+name.gsub(' ','%20')
    req = Net::HTTP::Put.new(path, initheader = {'Content-Type' =>'application/json'})
    req.body = updatedBook.to_json
    response = Net::HTTP.new(@@api_host, @@api_port).start {|http| http.request(req) }
  end
end
