require 'resolv'
require_relative 'color'

class DNS_Enum

  def initialize(domain)
    @domain = domain
  end


  def scan
  
    resolver = Resolv::DNS.new

  
    begin
    
      # Enumerate nameservers
    
      nameservers = resolver.getresources(@domain, Resolv::DNS::Resource::IN::NS)
    
      puts "Nameservers for #{@domain}:".blue
    
      nameservers.each do |ns|
      
        puts "  #{ns.name}".blue
    
      end

    # Enumerate MX records
    
      mx_records = resolver.getresources(@domain, Resolv::DNS::Resource::IN::MX)
      puts "MX records for #{@domain}:".blue
      mx_records.each do |mx|
        puts "  #{mx.exchange} (priority #{mx.preference})".blue
      end

    # Enumerate A records
      a_records = resolver.getresources(@domain, Resolv::DNS::Resource::IN::A)
      puts "A records for #{@domain}:".blue 
      a_records.each do |a|
        puts "  #{a.address}".blue
      end

    # Enumerate CNAME records
      cname_records = resolver.getresources(@domain, Resolv::DNS::Resource::IN::CNAME)
      puts "CNAME records for #{@domain}:".blue
      cname_records.each do |cname|
        puts "  #{cname.name}".blue
      end

      rescue Resolv::ResolvError => e
        puts "Error resolving DNS records for #{@domain}: #{e}".blue
      end
  end
end


#host = "apple.com"
#scanner = DNS_Enum.new(host).scan





