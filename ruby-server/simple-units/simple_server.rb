require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept
  client.puts "...Receiving Client..."
  client.puts
  client.puts "Received at #{Time.now}"
  client.puts
  client.puts "...Reached the End..."
  client.close
}

