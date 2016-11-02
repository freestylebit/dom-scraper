#!/usr/bin/ruby

require 'io/console'

require 'mechanize'
require 'pry'

class Scraper
  def initialize(user, pass)
    @agent = Mechanize.new
    @login = 'https://mydom.dom.com/'
    @username = user
    @password = pass

    @account = Hash.new
  end

  def query
    login_page = @agent.get(@login)
    login_form = login_page.form(name: 'Login')
    login_form.fields[6].value = @username
    login_form.fields[7].value = @password

    page = @agent.submit login_form

    if (/https:\/\/mydom.dom.com\/siteminderagent\/forms\/login.fcc/.match(page.uri.to_s))
      return '--> Something went wrong!  Maybe check your credentials?'
    else
      self.analyze_account(page)
      return @account
    end
  end

  def analyze_account(page)
    @account['bill'] = page.at('#homepageContent .contentRowPadding div:nth-child(2) p span').text.strip
    @account['due_date'] = page.at('#homepageContent .contentRowPadding div:nth-child(1) p span').text.strip

    detail = @agent.get('/Usage/ViewPastUsage?statementType=4')
    @account['usage'] = detail.at('#pageContent .row.contentRowPadding table#paymentsTable tr:nth-child(2) td:nth-child(5)').text.strip
    @account['service_start'] = detail.at('#pageContent .row.contentRowPadding table#paymentsTable tr:nth-child(2) td:nth-child(1)').text.strip
    @account['service_end'] = detail.at('#pageContent .row.contentRowPadding table#paymentsTable tr:nth-child(3) td:nth-child(1)').text.strip
  end
end

puts '--> To acquire your latest utility specs, please enter your credentials'
puts
print '--> Username: '
user = gets.strip
puts
print '--> Password: '
pass = STDIN.noecho(&:gets).strip
puts

scraper = Scraper.new(user, pass);
puts scraper.query
