#!/usr/bin/ruby

load "lib/scraper.rb"

# Generate code coverage report.
require 'simplecov'
SimpleCov.start

describe "Scraper" do
  it "yields a message saying credentials are incorrect with bad username and password" do
  end
end