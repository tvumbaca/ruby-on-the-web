#We use the class Net::HTTP to GET, POST, PUT or DELETE
# This is really intuitive because the name of the class HTTP___ 
#determines the response type.

#Issuing GET requests:

require 'net/http'

url = 'http://www.google.com'
resp = Net::HTTP.get_response(URI.parse(url))

resp_text = resp.body

p resp_text

#Issuing POST requests:

require 'net/http'

url = 'http://www.google.com'
params = {
  firstName => 'John',
  lastName => 'Doe'
}

resp = Net::HTTP.post_form(url, params)

p resp_text = resp.body