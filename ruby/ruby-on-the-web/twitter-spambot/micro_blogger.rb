require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length > 140
      puts "WARNING!! Message too long."
    else
      @client.update(message)
    end
  end

  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    if followers_list.include? target
      tweet("d @#{target} #{message}")
    else
      puts "WARNING!! #{target} doesn't follow you!"
    end
  end

  def followers_list
    @client.followers.collect { |follower| @client.user(follower).screen_name}
  end

  def spam_my_followers(message)
    followers_list.each { |follower| tweet("dm #{follower} #{message}")}
  end

  def everyone_last_tweet
    friends = @client.friends.sort_by { |friend| @client.user(friend).screen_name }
    friends.each do |friend|
      print @client.user(friend).screen_name
      puts @client.user(friend).status.created_at.strftime(" %A, %b %d")
      puts @client.user(friend).status.text
      puts""
    end
  end

  def shorten(original_url)
    Bitly.use_api_version_3
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    puts "Shortening this URL: #{original_url}"
    return bitly.shorten(original_url).short_url
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
      when 'spam' then spam_my_followers(parts[1..-1].join(" "))
      when 'elt' then everyone_last_tweet
      when 's' then shorten parts[1..-1]
      when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
      else
        puts "Sorry, I don't know how to #{command}"
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run