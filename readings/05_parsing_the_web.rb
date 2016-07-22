#Parsing web feeds with Feedzirra:
#Web feeds are special XML files designed to contain multiple items of content.
#They are commonly used by blogs as a way for users to subscribe to them.
# Two popular feeds are RSS and Atom. These feeds are formatted to be
#machine friendly - they're easier for programs to parse compared with scanning
#inconsistent HTML.

#Processing an RSS feed:

require 'rubygems'
require 'feedjira'

feed = Feedjira::Feed.fetch_and_parse('http://www.rubyinside.com/feed/')

puts "This feed's title is #{feed.title}"
puts "This feed's Web site is at #{feed.url}"

feed.entries.each do |item|
	puts item.title + "\n---\n" + item.summary + "\n\n"
end