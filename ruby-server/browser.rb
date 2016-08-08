require 'socket'

host = 'localhost'
port = 2000

input = gets.chomp
message = input.split(/\s+/)
rest_verb = message[0]
url_path = message[1]
browser_http_version = message[2]

path = "index.html"

request = "#{rest_verb} #{url_path} #{browser_http_version}\r\n\r\n"

#request = "GET #{path} HTTP/1.1\r\n\r\n"


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



#* modify client to accept input for sending requests - GET and POST
#* set up header request line
#* in POST, ask for username and email
#

