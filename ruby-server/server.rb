require 'socket'
require 'filemagic'

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
    
      #parse_request
      
      
      
      #client.puts "hello world" if check_http_version == true
      
      #check_rest_verb
      
      
      
      client.puts "#{HTTP_VERSION} #{status_number_200} #{status_message_200}\nDate:           #{current_date_time}\nContent-Type:   #{acquire_mime_type}\nContent-Length: #{acquire_file_size}\r\n\r\nBODY"
      
      
      
      puts
      puts "...Receiving..."
      client.close
    end
  end
  
  def current_date_time
    Time.now.strftime("%d-%m-%Y %H:%M:%S")
  end
  
  def acquire_mime_type
    FileMagic.new(FileMagic::MAGIC_MIME).file("index.html")
  end
  
  def acquire_file_size
    "#{File.size("index.html")} bytes"
  end
  
  def parse_request
    resource_exist?
    if validate_http_version == true
      #acquire_rest_verb
    end
  end
  
  def validate_http_version
    if client_http_version == HTTP_VERSION
      true
    else
      client.puts error_505
      client.close
    end
  end
  
  def acquire_rest_verb
    if REST_VERBS.include? client_rest_verb
      client_rest_verb
    else
      client.puts error_404
      client.close
    end
  end
  
  def check_resource_path
    #regex to find "./" at start of client_resource
    #if present, proceed to resource_exist?
    #if not present, make path: "./" + client_resource then proceed to resource_exist?
  end
  
  def resource_exist?
    if File.exist?(client_resource)
      get_resource
    else
      client.puts "#{error_404} - could not find #{client_resource}"
    end
  end
  
  def get_resource
    path = "./index.html"
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
  
  
  
  def status_200
    "#{status_number_200}: #{status_message_200}"
  end
  
  def status_message_200
    "OK"
  end
  
  def status_number_200
    "Status 200"
  end
  
  
  
  def error_404
    "#{error_number_404}: #{error_message_404}"
  end
  
  def error_405
    "#{error_number_405}: #{error_message_405}"
  end
  
  def error_505
    "#{error_number_505}: #{error_message_505}"
  end
  
  def error_message_404
    "Not Found"
  end
  
  def error_message_505
    "HTTP Version not supported"
  end
  
  def error_number_404
    "Error 404"
  end
  
  def error_number_405
    "Error 405"
  end
  
  def error_number_505
    "Error 505"
  end
end

MiniServer.new

#TO DO:
#+ divide input into array
#+ check http version at slot 2; if version does not match up, redirect to 505 error
#+ when 505, STOP entire request
#+ when http version matches, check for REST verb included in slot 0
#+ check for GET verb, else redirect to 405 error.
#* Standardise relative resource path and make absolute
#* if slot 0 == GET then check for resource at slot 1
#* if resource present - return it; if resource not present redirect to 404 error
#* out response line: HTTP version 202 Success
#* assign header Date to Time.now
#* assign header Content-type to extension of file requested else
#* assign header Content-length to byte length of file requested
#* 