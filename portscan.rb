require 'socket'
require_relative 'color'

class PortScan

  def initialize(host)
    @host = host
  end


  def scan()    
    ports = (1..65535).to_a
    
    target = "[*]Target: #{@host}".blue
    padding = "+"+"-"*target.length+"+".blue

    puts padding
    puts target
    puts padding
    for port in ports
      begin 
        s = TCPSocket.new(@host,port)
        puts "[+]Port : #{port} => open".blue
        s.close
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        #puts "[-]Port : #{port} => close"
      end
      break if port == 65535
    end
  end
end

#host = "127.0.0.1"
#PortScan.new(host).scan

