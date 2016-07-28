require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
  attr_reader :client
  
  def initialize
    Bitly.use_api_version_3
    @bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    
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
      when 'q' 
        puts "Goodbye!"
      when 't' 
        tweet(parts[1..-1].join(" "))
      when 'dm' 
        target = parts[1]
        message = parts[2..-1].join(" ")
        follower_not_found_response = "You can't send direct messages to #{target} because #{target} isn't following you!"

        (current_followers.include? target)? dm(target,message) : (p follower_not_found_response)
      when 'spam'
        spam_my_followers(parts[1..-1].join(" "))
      when 'elt'
        everyones_last_tweet
      when 'turl'
        tweet(parts[1..-2].join(" ") + " " + shorten_this(parts[-1]))
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

  def current_followers
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name}
  end

  def follower_list
    screen_names = []
    @client.followers.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    
    screen_names
  end

  def spam_my_followers(message)
    follower_list.each do |follower|
      dm(follower, message)
    end
  end

  def everyones_last_tweet
    friends = @client.followers.collect { |follower| @client.user(follower)}
    friends = friends.sort_by! { |friend| friend.screen_name.downcase}
    
    friends.each do |friend|
      timestamp = friend.status.created_at
      time = timestamp.strftime("%A, %b %d")
      
      puts "#{friend.screen_name} said on #{time}:"
      puts friend.status.text
      puts ""
    end
  end
  
  def shorten_this(original_url)
    puts "Shortening this URL: #{original_url}"
    return @bitly.shorten(original_url).short_url
  end
end

blogger = MicroBlogger.new
blogger.run
