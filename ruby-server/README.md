##Exploration
This is a small, local API using TCP sockets and servers to demonstrate how a basic client and server interact with one another.

From [The Odin Project's](http://www.theodinproject.com/ruby-programming/ruby-on-the-web) curriculum.

##Exposition
This project tested my understanding of how REST convetion works. It acts as a precursor to understanding how the routes in the Ruby on Rails are utilised. A post is used as an example:

1. GET - all posts --> **#index**
2. GET - single post --> **#show**
3. GET - new post form --> **#new**
4. POST - create post --> **#create**
5. GET - edit post form --> **#edit**
6. PUT - update post --> **#update**
7. DELETE - destroy post --> **#delete**

The requests managed by this server are GET and POST requests.

To run a GET request, type: `GET index.html HTTP/1.1`.

To run a POST request, type `POST thanks.html HTTP/1.1`.

Statuses returned include:
- 404: Not Found
- 405: Method Not Allowed
- 505: HTTP version not supported


##Excursion
- Note that the `\r\n\r\n` sent as part of the request client-side is really important. When the server accepts a client connection and tries to read the request with `.gets`, if the request does not end with this convention, you can run into buggy, incomplete parsing issues.
- Status Messages can be summarised [here](http://code.tutsplus.com/tutorials/http-the-protocol-every-web-developer-must-know-part-1--net-31177):
  - 1XX Info
  - 2xx Success
  - 3XX Redirection
  - 4XX Client Error
  - 5XX Server Error