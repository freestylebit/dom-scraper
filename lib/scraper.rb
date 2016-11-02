#!/usr/bin/ruby

require 'mechanize'
require 'pry'

load "lib/helper.rb"

class Scraper
  include Helper

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
    @account['bill'] = parse_text(page.at('#homepageContent .contentRowPadding div:nth-child(2) p span'))
    @account['due_date'] = parse_text(page.at('#homepageContent .contentRowPadding div:nth-child(1) p span'))

    detail = @agent.get('/Usage/ViewPastUsage?statementType=4')
    @account['usage'] = parse_text(detail.at('#pageContent .row.contentRowPadding table#paymentsTable tr:nth-child(2) td:nth-child(5)'))
    @account['service_start'] = parse_text(detail.at('#pageContent .row.contentRowPadding table#paymentsTable tr:nth-child(2) td:nth-child(1)'))
    @account['service_end'] = parse_text(detail.at('#pageContent .row.contentRowPadding table#paymentsTable tr:nth-child(3) td:nth-child(1)'))
  end

end
