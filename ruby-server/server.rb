require 'socket'

server = TCPServer.open(2000)
loop do
  client = server.accept
  puts client.gets
  
  client.puts "HEADER Response Line 1)http version 2) XXX 3)Explanation\nHeader 1\nHeader 2\nHeader 3\r\n\r\nBODY"
  
  path = "index.html"
  file = File.new(path)
  
  client.puts "#{file.read}"
  file.close
  
  puts
  puts "...Receiving..."
  client.close
end
