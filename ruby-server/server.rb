require 'socket'

module HTTP_protocol
  HTTP_VERSION = "HTTP/1.1"
  REST_VERBS = ["GET", "PUT", "POST", "DELETE"]
end


class MiniServer
  include HTTP_protocol  
  
  attr_reader :client, :client_request
  
  def initialize
    @server = TCPServer.open(2000)
    @client_request = []
    
    
    
    listen_for_request
  end
  
  def listen_for_request
    loop do
      @client = @server.accept
      @client_request = (client.gets).split
    
    parse_request
      
      
      
      #client.puts "hello world" if check_http_version == true
      
      #check_rest_verb
      
      
      
      #client.puts "HEADER Response Line 1)http version 2) 3)Explanation\nDate:\nContent-Type:\nContent-Length:\r\n\r\nBODY"
      
      #locate_file
      
      puts
      puts "...Receiving..."
      client.close
    end
  end
  
  def parse_request
    check_http_version
    check_rest_verb
  end
  
  def check_http_version
    if client_http_version == HTTP_VERSION
      true
    else
      client.puts error_message_505
    end
  end
  
  def check_rest_verb
    if REST_VERBS.include? client_rest_verb
      client_rest_verb
    else
      client.puts error_message_404
    end
  end
  
  def locate_file
    path = "index.html"
    file = File.new(path)
    
    client.puts "#{file.read}"
    file.close
  end
  
    
    
  private
  
  def client_rest_verb
    client_request[0]
  end
  
  def client_resource
    client_request[1]
  end
  
  def client_http_version
    client_request[2]
  end
  
  
  
  
  
  def error_message_404
    "Not Found"
  end
  
  def error_message_405
    "Method not Allowed"
  end
  
  def error_message_505
    "HTTP Version not supported"
  end
  
  def error_number_404
    "404"
  end
  
  def error_number_405
    "405"
  end
  
  def error_number_505
    "505"
  end
end

MiniServer.new

#TO DO:
#+ divide input into array
#+ check http version at slot 2; if version does not match up, redirect to 505 error
#- when 505, STOP entire request
#- when http version matches, check for REST verb included in slot 0
#- GET for now otherwise redirect to 405 error.
#- if slot 0 == GET then check for resource at slot 1
#- if resource present - return it; if resource not present redirect to 404 error
