require 'socket'
require 'json'

class MiniBrowser
  attr_reader :host, :port, :input
  attr_accessor :request

  def initialize
    @host = 'localhost'
    @port = 2000
    
    browse
  end

  def browse
    get_input
    filter_input
  end
  
  def get_input
    #http_method = gets.chomp
    #url_path = gets.chomp
    #browser_http_version = gets.chomp
    @input = gets.chomp
    #@input = "POST thanks.html HTTP/1.1"
    @request = "#{http_method} #{url_path} #{browser_http_version}\r\n\r\n"
    
  end
  
  def filter_input
    case
    when http_method == "GET"
      send_request
    when http_method == "POST"
      acquire_user_info
      send_request
    else
      send_request
    end
  end

  def acquire_user_info
    puts "What is your username?"
    user_name = gets.chomp
    #user_name = "Cornelius"
    puts "What is your email?"
    user_email = gets.chomp
    #user_email = "cornelius.soon@gmail.com"
    
    message_body = {viking: {name: user_name, email: user_email}}
    message_body = message_body.to_json
    
    @request = @request.sub("\r\n\r\n", " #{message_body}\r\n\r\n")
  end

  def message
    input.split(/\s+/)
  end

  def http_method
    message[0]
  end

  def url_path
    message[1]
  end

  def browser_http_version
    message[2]
  end

  #path = "index.html"
  #request = "GET #{path} HTTP/1.1\r\n\r\n"

  def send_request
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
  end

end

MiniBrowser.new

#+ modify client to accept input for sending requests - GET and POST
#+ set up header request line - Content-Type JSON, Content-length length of json string
#* 
#* in POST, ask for username and email
#* package username and email as json string to send over


#* browser to read request as POST
#* browser to break apart the body from the header
#* browser to check if thanks.html exist
#* browser to deserialise json string
#* browser to place ruby objects as list_items
#* browser to .gsub <%= yield %> with the list_items
#* browser to return 202 success and formatter message body

