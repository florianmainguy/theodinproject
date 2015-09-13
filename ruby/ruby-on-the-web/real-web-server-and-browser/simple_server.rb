require 'socket'
require 'json'

server = TCPServer.open(2000)

loop do
  client = server.accept

  # Get the header only of the request received
  header = ""
  while line = client.gets
    header += line
    break if header =~/\r\n\r\n$/
  end

  method = header.split[0]
  path = header.split[1][1..-1]
  version = header.split[2]

  # Get the body, thanks to the body size sent in the header
  body_size = header.split(' ').last.to_i
  body = client.read(body_size)

  # Check if the file requested exists. If not, error 404
  if File.exist?(path)
    file = File.open(path)

    case method
    when 'GET'
      client.puts "GET #{path} #{version} 200 OK\n" +
                  "#{Time.now.ctime}\n" +
                  "Content length: #{file.size}\r\n\r\n" +
                  "#{file.read}"
    when 'POST'
      params = JSON.parse(body)

      data = "<li>Name: #{params['user']['name']}</li>\n\t" +
             "<li>Email: #{params['user']['email']}</li>"

      client.puts "POST #{path} #{version} 200 OK\n" +
                  "#{Time.now.ctime}\n" +
                  "Content length: #{file.size}\r\n\r\n" +
                  "#{file.read.gsub('<%= yield %>', data)}"
    end
  else
    client.puts "#{version} 404 Not Found"
  end
  client.puts
  client.puts "Closing the connection. Bye!"
  client.close
end