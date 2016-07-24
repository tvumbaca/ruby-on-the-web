require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client
  
  def initialize
    puts "__Initializing MicroBlogger__"
    @client = JumpstartAuth.twitter
  end
  
  def tweet(message)
    case 
    when message.length <= 140
      @client.update(message)
    else
      puts "Error: Message will not be posted as it is greater than 140 characters."
    end
  end
  
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "Enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      
      case command
      when 'q' then puts "Goodbye!"
      when 't' then tweet(parts[1..-1].join(" "))
      when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      else
        puts "Sorry, I don't know how to #{command}"
      end
    end
  end
  
  def dm(target, message)
    puts "Target acquired: #{target}. Sending direct message:"
    puts message
    message = "d @#{target} #{message}"
    tweet(message)
end



blogger = MicroBlogger.new
blogger.run

#blogger.tweet(message1)

