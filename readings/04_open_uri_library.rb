#open-uri is a library that wraps the functionality of net/http, net/https and
#net/ftp into a single package making it a lot easier to perform all the main
#functions.
# A key part of open-uri is the way it abstracts common Internet actions and
#allows file I/O techniques to be used upon them. This enables the retrieval
#of a document on the Web to become like opening a text file locally.

#Demonstration of I/O similarity:

require 'open-uri'

f = open('http://www.rubyinside.com/test.txt')
puts f.readlines.join

# => Hello Beginning Ruby reader!



#Another demonstration of I/O similarity:

require 'open-uri'

f = open('http://www.rubyinside.com/test.txt')

puts "The document is #{f.size} bytes in length"

f.each_line do |line|
	puts line
end

f.each_line do |line|
  puts line
  asd
end

# => The document is 29 bytes in length
# => Hello Beginning Ruby reader!



#Using an open block style, similar to the File class:

require 'open-uri'

open('http://www.rubyinside.com/test.txt') do |f|
	puts f.readlines.join
end



#Return particulars about the HTTP response itself

require 'open-uri'

f = open('http://www.rubyinside.com/test.txt')

puts f.content_type
puts f.charset
puts f.last_modified

# => text/plain
# => iso-8859-1
# => 2006-10-15 01:24:13 UTC

