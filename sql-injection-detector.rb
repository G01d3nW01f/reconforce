require 'http'

class SQLinjectionDetector
  
  def initialize(url)
    @url = url
  end

  def scan

    payloads = ["' OR 1=1; --","' OR '1'='1"]
    payloads.each do |payload|
      response = HTTP.get(@url + payload)
      if response.code == 200
        puts "[+]Possible SQL Injection Vulnerabillity Found At #{@url}".blue
        break
      else
        puts "[!]Not Vulnerabillity".red
      end
    end
  end
end


#test_url = "http://testphp.vulnweb.com/artists.php?artist=1"
#SQLinjectionDetector.new(test_url).scan

