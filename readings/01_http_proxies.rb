#proxy n. "acting on behalf of another"; stand-in, go-bewteen

#Proxying occurs when HTTP requests do not go directly betwen the HTTP server
#but through a third-party.
# A common secnario of this occurs in schools and offices where web access is
#regulated or filtered.

#Net::HTTP::Proxy creates a new proxy class to utilise
#Proxies will include a hostname and a port number to reference. In the

require 'net/http'

web_proxy = Net::HTTP::Proxy('your.proxy.hostname.or.ip', 8080)

url = URI.parse('http://www.rubyinside.com/test.txt')

web_proxy.start(url.host, url.port) do |http|
	req = Net::HTTP::Get.new(url.path)
	puts http.request(req).body
end