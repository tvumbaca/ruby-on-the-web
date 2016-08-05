require 'socket'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

#Puts the object id down.
#Reads the first line of that object and the pointer is moved
#to the end of the line.
#In the following block of code this means that the first line is not read twice
puts "---------------------------------------"
puts "Doing: \r\nputs s\r\nputs s.gets"
puts
puts s
puts s.gets
puts "---------------------------------------"



#This is a simple loop to get the contents of the server; essentially the socket
#has acquired a body of contents from which to extract information 
puts "---------------------------------------"
puts "Doing: \r\nwhile line = s.gets\r\n  puts line\r\nend\r\n\r\ns.close"
puts
while line = s.gets
  puts line
end
#This closes the socket, you cannot do `s.rewind` like you would for a file
#therefore you close the socket and if you want to retrieve the contents from
#the server gain you do open a new channel
s.close
puts "---------------------------------------"



#This TRIES to reopen the socket. The socket is still pointing to the same
#location so you can call the object id of the socket but you cannot gets the
#content anymore. You get an error "closed stream"
puts "---------------------------------------"
puts "Doing: \r\nputs s\r\ns.close"
puts
puts s
puts s.gets
s.close
puts "---------------------------------------"


