require "socket"
require 'eventmachine'

class Client < EventMachine::Connection

  def post_init
    set_sock_opt(Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, true)
    set_sock_opt(Socket::SOL_TCP, Socket::TCP_KEEPIDLE, 50)
    set_sock_opt(Socket::SOL_TCP, Socket::TCP_KEEPINTVL, 10)
    set_sock_opt(Socket::SOL_TCP, Socket::TCP_KEEPCNT, 5)
  end

  def receive_data(data)
    puts data
  end
  
  def unbind
    puts "Connection terminated"
  end
  
end

server = ARGV[0]
port   = Integer(ARGV[1])
connections = Integer(ARGV[2])

puts "Connecting to #{server}:#{port} #{connections} times"

EventMachine.run {
  connections.times{ 
    EventMachine::connect(server, port, Client) 
    sleep(0.05)
  }
}
