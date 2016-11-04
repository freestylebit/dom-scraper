#!/usr/bin/ruby
# frozen_string_literal: true

require 'mechanize'
require 'pry'

require_relative 'helper.rb'

# Class to query for scraped data from Dominion Power's Utility website.
class Scraper
  include Helper

  def initialize(user, pass)
    @agent = Mechanize.new
    @login = 'https://mydom.dom.com/'
    @username = user
    @password = pass

    @account = {}
  end

  # Handles query requests.  If nothing is wrong, return value should be empty.
  def query
    page = login

    # A way to check if the login failed is if the page simply has a logout link.
    if parse_text(page.at('#mydom-nav-menu li:nth-child(3) a')) == 'Sign Out'
      analyze_account(page)
      ''
    else
      '--> Something went wrong! Maybe check your credentials?'
    end
  end

  # Attempt to log into system.
  def login
    login_page = @agent.get(@login)
    login_form = login_page.form(name: 'Login')
    login_form.fields[6].value = @username
    login_form.fields[7].value = @password

    @agent.submit login_form
  end

  # Query for all metadata requested.
  def analyze_account(page)
    @account['bill'] = parse_text(page.at('.contentRowPadding:nth-child(7) div:nth-child(2)'))
    @account['due_date'] = parse_text(page.at('.contentRowPadding div:nth-child(1) p span'))

    d = @agent.get('/Usage/ViewPastUsage?statementType=4')
    @account['usage'] = parse_text(d.at('#paymentsTable tr:nth-child(2) td:nth-child(5)'))
    @account['service_start'] = parse_text(d.at('#paymentsTable tr:nth-child(2) td:nth-child(1)'))
    @account['service_end'] = parse_text(d.at('#paymentsTable tr:nth-child(3) td:nth-child(1)'))
  end

  # Getter methods for all values in class.
  # a_ = account_
  def a_bill
    @account['bill']
  end

  def a_due_date
    @account['due_date']
  end

  def a_usage
    @account['usage']
  end

  def a_service_start
    @account['service_start']
  end

  def a_service_end
    @account['service_end']
  end
end
