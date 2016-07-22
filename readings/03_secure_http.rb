#HTTP is unencrypted. It's unsuitable for transferring sensitive data like
#credit card information.
# HTTPS is the same as HTTP but routed over Secure Socket Layer making it
#very difficult (but still possible) to be read by third parties.

require 'net/http'
require 'net/https'

url = URI.parse('http//example.com')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true if url.scheme == 'https'

request = Net::HTTP::Get.new(url.path)
puts http.request(request).body

#The scheme method checks to see if the remote URL is indeed one that requires
#SSL to be activated.
# Once a secure connection is set up, it is easy to send sensitive form-post
#information to the remote server:

require 'net/http'
require 'net/https'

url = URI.parse('https://example.come/')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true if url.scheme == 'https'

request = Net::HTTP::Post.new(url.path)
request.set_form_data({ 'credit_card_number' => '1234123412341234'})
puts http.request(request).body