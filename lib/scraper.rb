#!/usr/bin/ruby
# frozen_string_literal: true

require 'mechanize'
require 'pry'

require_relative 'helper.rb'

class Scraper
  include Helper

  def initialize(user, pass)
    @agent = Mechanize.new
    @login = 'https://mydom.dom.com/'
    @username = user
    @password = pass

    @account = {}
  end

  def query
    login_page = @agent.get(@login)
    login_form = login_page.form(name: 'Login')
    login_form.fields[6].value = @username
    login_form.fields[7].value = @password

    page = @agent.submit login_form

    # A way to check if the login failed is if we get redirected
    # back to the same page.
    if /https:\/\/mydom.dom.com\/siteminderagent/.match(page.uri.to_s)
      return '--> Something went wrong!  Maybe check your credentials?'
    else
      analyze_account(page)
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
