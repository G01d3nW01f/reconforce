require 'resolv'

class SubdomainFinder
  def initialize(target)
    @target = target
  end

  def scan
    resolver = Resolv::DNS.new

    subdomains = []
    resolver.each_resource(@target, Resolv::DNS::Resource::IN::NS) do |resource|
      subdomains << resource.name.to_s
    end

    if subdomains.any?
      puts "Subdomains found:"
      puts subdomains
    else
      puts "No subdomains found"
    end

  end
end



