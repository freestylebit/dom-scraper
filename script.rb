#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/scraper.rb'

require 'io/console'

puts '--> To acquire your latest utility specs, please enter your credentials'
puts
print '--> Username: '
user = gets.strip
puts
print '--> Password: '
pass = STDIN.noecho(&:gets).strip
puts
puts '--> Give me one sec...'
puts
puts

scraper = Scraper.new(user, pass)
results = scraper.query
puts
puts '--------------------------------------'
puts '            Account Summary           '
puts '--------------------------------------'
print 'Bill Amount       | ' + results['bill']
puts
print 'Bill Due Date     | ' + results['due_date']
puts
puts
print 'Usage (kWh)       | ' + results['usage']
puts
print 'Meter Start Date  | ' + results['service_start']
puts
print 'Meter End Date    | ' + results['service_end']
puts
puts '--------------------------------------'
puts
