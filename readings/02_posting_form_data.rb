#Previous interactions involved retrieving data.
#It is also posible to send data to a web server.
#A basic example of this is filling out a form on a web page.
#The hash acts as the form data.

require 'net/http'

url = URI.parse('http://www.rubyinside.com/test.cgi')

response = Net::HTTP.post_form(url,{'name' => 'David', 'age' => '24'})
puts response.body 

#Before post_form:
# You say ___ is __ years old.

#After post_form:
# You say David is 24 years old.



#There is a complex, lower-level way to achieve the same thing.
# We would achieve the same thing by taking control of each step of the
#form submission process.