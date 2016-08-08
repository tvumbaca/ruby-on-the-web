require 'socket'

host = 'localhost'
port = 2000
path = "/index.html"

request = "GET #{path} HTTP/1.1\r\n\r\n"

socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
headers, body = response.split("\r\n\r\n")
if !headers.nil?
  puts
  puts headers
end
if !body.nil?
  puts
  puts
  puts body
end

socket.close



















puts