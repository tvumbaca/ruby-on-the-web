##HTTP:
=======

Hypertext Transfer Protocol is the network protocol used to deliver all data on the World Wide Web, WWW.

A browser is the HTTP client because it sends requests to a HTTP server or web server. The web server sends responses back to the client. The standard port that servers listen on is 80, however any port can be used.

HTTP takes place through TCP/IP sockets??

###Resources:
It's the R in URL - a chunk of information, a simple eexample is a file, but it can also be a dynamically generated query result dervied from server-side script output.

##HTTP Transactions:
=====================

Like most network protocols, HTTP uses the client-server model: A HTTP client opens a connection and sends a request message to a HTTP server; the server then returns a response message containing the resource requested.
After delivering the response, the server closes the connection. This makes the HTTP a stateless protocol ie, not maintaining connection information between transactions.
The format of the request and response messages are similar. Both kinds of messages consist of:
- an initial line
- zero or more header lines
- a blank line and
- an optional messaage body: eg, a file, query data or query output

The format of a HTTP message:

```
<initial line, different for request vs. response>
Header1: value1
Header2: value2
Header3: value3

<optional message body goes here, like file contents or query data;
it can be many lines long or even bindary data $&%^@!>
```

###Initial Request Line:
A request line has three parts separated by spaces:
- a method name,
- the local path of the requested resource,
- and the version of HTTP being used

A typical request line:

GET /path/to/file/index.html HTTP/1.0

GET is the most common HTTP method; it says "give me this resource".
Method names are always uppercase.
The path is the part of the URL after the host name.
The HTTP version always takes the form "HTTP/x.x" uppercase.

###Initial Response Line (Status Line)
The initial response line also has three parts separated by spaces: the HTTP version, a response status code that gives the result of the request. It also includes a human readable phrase.

A typical status line:

  HTTP/1.0 200 OK
or
  HTTP/1.0 404 Not Found

The status code is a three-digit integer and the first digit identifies the general category response:
- 1xx indicates an information message only
- 2xx indicates success of some kind
- 3xx redirects the client to another URL
- 4xx indicates an error on the client's part
- 5xx indicates an error on the server's part

The most common status codes are:
- 200 OK
  The request succeeded, and the resulting resource is returned in the message body.

- 404 Not Found
  The requested resource doesn't exist.

- 301 Moved Permanently
- 302 Moved Temporarily
- 303 See Other
  The resource has moved to another URL given by the Location: response header and should be automatically retrieved by the client. The browser is redirected to an existing file.

- 500 Server Error
  An unexpected server error. The most cmmon cause is a server-sde script that has bad syntax, fails or otherwise can't run properly

###Header Lines
Header lines provide information about the request, reponse or object sent in the message body. The header lines have a format: one line per header: `Header-Name: value` ending with CRLF (carriage return, line feed).
- The header lines should end in CRLF but also handle LF correctly.
- The header name is not case-sensitive.
- As much space or tabs may be between the `:` and the value.
- Header lines beginning with space or tab are part of the previous header line folded into multiple lines for easy reading.

The following two headers are equivalent:
```
Header1: value-1a, value-1b

Header1:          value-1a,
                  value-1b
```
HTTP has about 46 headers and one **Host:** is required in requests. There is a balance ebtween webmasters logging needs and the user's privacy needs.
For Net-politeness:
- The **From:** header gives the email address of whoever is making the request.
- The **User-Agent: Program-name/version_#** header identifies the program that's making the request.

If you are writing servers, consider including these headers in your responses:
- The **Server: Program-name/version_#** header is analogous to the User-Agent: header - it defines the server software used.
- The **Last-Modified:** header gives the modification date of the resource being returned - `Last-Modified: Day, Date Time`

###The Message Body
An HTTP message may have the body of data sent after the header lines.
In a response, this is where the requested resource is reutrned to the client - or an error message.
In a request, this is where user-entered data or uploaded files are sent to the server.

If a HTTP message includes a body, there are usually header lines in the message that describe the body, in particular:
- The **Content-Type:** header gives the MIME-type of the data in the body such as *txt/html* or *image/gif*
- The **Content-Length:** header gives the number of bytes in the body.

##Sample HTTP Exchange
=======================
To retrieve the file at the URL

    `http://www.somehost.com/path/file.html`

first open a socket to the host www.somehost.com, port 80 (use the default port of 80 because none is specified in the URL). Then, send something like the following through the socket:
```
    GET /path/file.html HTTP/1.0
    From: someuser@jmarshall.com
    User-Agent: HTTPTool/1.0
    [blank line here]
```
The server should respond with something like the following, sent back through the same socket:
```
    HTTP/1.0 200 OK                               # status line
    Date: Fri, 31 Dec 1999 23:59:59 GMT           # header line 1
    Content-Type: text/html                       # header line 2
    Content-Length: 1354                          # header line 3

    <html>                                        # message body start
    <body>                                        |
    <h1>Happy New Millennium!</h1>                |
    (more file contents)                          |
      .                                           |
      .                                           |
      .                                           |
    </body>                                       v
    </html>                                       # message body finish
```
After sending the response, the server closes the socket.

##Other HTTP Methods
=====================
Besides GET, the other two most commonly used methods are HEAD and POST

###The HEAD Method
A HEAD request is like a GET request, except it asks the server to return the response headers only but not the actual resource (no message body). This is useful to check the characteristics of a resource without actually downloading it - saving bandwidth and time.

The response to a HEAD request must NEVER contain a message body (sensitive information), just the status line and headers only.

###The POST Method
A POST request is used to send data to the server to be processed by a CGI script (a common gateway interface is any program that runs on a web server).

A POST request sends away a block of data to the the intended request URI - which is not a resoruce to retrieve but a program to handle the data sent. The HTTP response is normall a program output not a static file.

The most common use of POST, by far, is to submit HTML form data...