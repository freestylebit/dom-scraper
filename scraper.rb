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

    self.analyze_account(page)
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


scraper = Scraper.new('user', 'pass');
scraper.query
