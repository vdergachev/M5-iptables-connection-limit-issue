require 'socket'      # Sockets are in standard library

server = TCPServer.new(30123)

begin
    while connection = server.accept
	puts "New connection"
        #line = connection.gets
        #connection.puts "from server - received!\n"
        #server.close
    end

rescue Errno::ECONNRESET, Errno::EPIPE => e
    puts e.message
    retry
end    
