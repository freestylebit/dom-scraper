#!/usr/bin/ruby

load "lib/scraper.rb"

require 'io/console'

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
