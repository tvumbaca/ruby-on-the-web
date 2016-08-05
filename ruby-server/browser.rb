require 'socket'

host = 'localhost'
port = 2000
path = "/index.html"

request = "GET #{path} HTTP/1.1\r\n\r\n"

socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
headers, body = response.split("\r\n\r\n")
puts
puts headers
puts
puts
puts body

socket.close



















puts