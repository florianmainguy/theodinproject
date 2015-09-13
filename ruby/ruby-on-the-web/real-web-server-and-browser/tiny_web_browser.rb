require 'socket'
require 'json'

host = 'localhost'
port = 2000

puts "Which kind of request do you want to send?"
input = gets.chomp.upcase

case input
when 'GET'
  request = "GET /index.html HTTP/1.0\r\n\r\n"
  
when 'POST'
  puts "What's your name?"
  name = gets.chomp.downcase
  puts "What's your email?"
  email = gets.chomp.downcase

  viking = {:user => {:name => name, :email => email}}
  json_hash = viking.to_json
  
  request = "POST /thanks.html HTTP/1.0\n" +
            "Content Length: #{json_hash.length}\r\n\r\n" +
            "#{json_hash}"
end

socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
puts response