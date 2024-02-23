require 'mechanize'
require 'nokogiri'
require_relative 'color'

class XSSScanner
  def initialize(url)
    @url = url
    @agent = Mechanize.new
  end

  def check_for_xss
    page = @agent.get(@url)
    form = page.forms.first
    form.fields.each do |field|
      original_value = field.value
      field.value = "<script>alert('XSS')</script>"
      begin
        page = form.submit
        if page.body.include? "alert('XSS')"
          text =  "[+]XSS vulnerability found on #{@url} in #{field.name} field".blue
          padding = "+"+"-"*text.length+"+"
          puts padding.blue 
          puts text.blue
          puts padding.blue
        end
      rescue Mechanize::ResponseCodeError => e
        puts "Error: #{e.response_code}".red
      ensure
        field.value = original_value
      end
    end
  end
end

#example
#scanner = XSSScanner.new("https://xss-game.appspot.com/level1/frame")
#scanner.check_for_xss


