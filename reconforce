#!/bin/ruby


#Module import

require_relative 'subdomain-finder'
require_relative 'xss_scanner'
require_relative 'dns-enumeration'
require_relative 'sql-injection-detector'
require_relative 'portscan'
require 'readline'


class String
  def red; colorize(self, "\e[1m\e[31m"); end
  def green; colorize(self, "\e[1m\e[32m"); end
  def dark_green; colorize(self, "\e[32m"); end
  def yellow; colorize(self, "\e[1m\e[33m"); end
  def blue; colorize(self, "\e[1m\e[34m"); end
  def dark_blue; colorize(self, "\e[34m"); end
  def purple; colorize(self, "\e[35m"); end
  def dark_purple; colorize(self, "\e[1;35m"); end
  def cyan; colorize(self, "\e[1;36m"); end
  def dark_cyan; colorize(self, "\e[36m"); end
  def pure; colorize(self, "\e[0m\e[28m"); end
  def bold; colorize(self, "\e[1m"); end
  def colorize(text, color_code) "#{color_code}#{text}\e[0m" end
end


trap('INT','SIG_IGN')
CMDS = ['help','portscan','xss_scanner','dns-enumerate','subdomain-finder','sql-injection-detector','exit']


asciiart = """
 _  _         _    ___  _____  ____        ___        
 | || |       | |  / _ \\|  __ \\|___ \\      / _ \\       
 | || |_ _   _| |_| | | | |__) | __) | ___| | | |_ __  
 |__   _| | | | __| | | |  _  / |__ < / __| | | | '_ \\ 
    | | | |_| | |_| |_| | | \\ \\ ___) | (__| |_| | | | |
    |_|  \\__,_|\\__|\\___/|_|  \\_\\____/ \\___|\\___/|_| |_|
                                                       
                                                       
"""

puts asciiart

completion = 
  proc do |str|
    case



    #Scan Phase

    when Readline.line_buffer =~ /portscan/i

      puts "[+]Enter the host or ip for PortScan".red
      host = gets.chomp

      scanner = PortScan.new(host).scan 
    
    when Readline.line_buffer =~ /xss_scanner/i

      puts "[+]Enter the URL for XSS scan".red  
      url = gets.chomp

      scanner = XSSScanner.new(url).check_for_xss

    when Readline.line_buffer =~ /sql-injection-detector/i

      puts "[+]Enter the URL for SQLinjection".red
      url = gets.chomp

      scanner = SQLinjectionDetector.new(url).scan

    when Readline.line_buffer =~ /dns-enumerate/i

      puts "[+]Enter the host for DNS scan".red
      host = gets.chomp

      scanner = DNS_Enum.new(host).scan


    when Readline.line_buffer =~ /help/i
      puts "Available commands:\n" + "#{CMDS.join("\n")}".red
    when Readline.line_buffer =~ /rubyfu/
      puts "Rubyfu, where ruby goes evil!".blue
    when Readline.line_buffer =~ /ls/i
      puts `ls`
    when Readline.line_buffer =~ /clear/i
      puts `clear`
    when Readline.line_buffer =~ /exit/i
      puts "Exiting...".red
      exit 0
    else
      CMDS.grep(/^#{Regexp.escape(str)}/i) unless str.nil?
    end
  end

Readline.completion_proc = completion
Readline.completion_append_character = ' '

while line = Readline.readline("[h4ck3r]>> ")
  puts completion.call
  break if line =~ /^quit*/i or line =~ /^exit$/i
end


