# frozen_string_literal: true

require_relative 'lib/scraper.rb'

require 'io/console'

namespace :scraper do
  task :dom do
    puts '--> To acquire your latest utility specs, please enter your credentials'
    puts
    print '--> Username: '
    user = STDIN.gets.strip
    puts
    print '--> Password: '
    pass = STDIN.noecho(&:gets).strip
    puts
    puts '--> Give me one sec...'
    puts
    puts

    scraper = Scraper.new(user, pass)
    result = scraper.query

    if result != ''
      puts result
      next
    end
    puts
    puts '--------------------------------------'
    puts '            Account Summary           '
    puts '--------------------------------------'
    print 'Bill Amount       | ' + scraper.a_bill
    puts
    print 'Bill Due Date     | ' + scraper.a_due_date
    puts
    puts
    print 'Usage (kWh)       | ' + scraper.a_usage
    puts
    print 'Meter Start Date  | ' + scraper.a_service_start
    puts
    print 'Meter End Date    | ' + scraper.a_service_end
    puts
    puts '--------------------------------------'
    puts
  end
end
