require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets) && !line.chomp.empty?  # Read the request and collect it until it's empty
    lines << line.chomp
  end
  puts lines                                        # Output the full request to stdout

  # Match your response with the requested file
  filename = lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')
  if File.exists?(filename)
    response_body = File.read(filename)
  else
    response_body = "File Not Found\n" # need to indicate end of the string with \n
  end

  client.puts(response_body)

  #  Create an HTML response
  # response = "
  #   <!DOCTYPE html>
  #   <html>
  #     <head>
  #       <title>My first web server</title>
  #     </head>
  #     <body>
  #       <h1>My first web server</h1>
  #       <p>Oh hey, this is my first HTML response!</p>
  #     </body>
  # </html>"

  # Move your HTML response into a file
  # filename = "index.html"
  # response = File.read(filename)

  #client.puts(response)

  #client.puts(Time.now.ctime)                       # Output the current time to the client
  client.close                                      # Disconnect from the client

end
