#!/usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'

require 'vcr'

describe 'Scraper' do
  before :each do
    WebMock.allow_net_connect!
  end

  it 'yields a message saying credentials are incorrect with bad username and password' do
    VCR.use_cassette('dominion_failed_login') do
      scraper = Scraper.new('user', 'pass')
      results = scraper.query

      expect(results).to eq('--> Something went wrong! Maybe check your credentials?')
    end
  end

  it 'yields some valid results with correct credentials.' do
    VCR.use_cassette('dominion_working_login') do
      scraper = Scraper.new(ENV['DOM_USERNAME'], ENV['DOM_PASSWORD'])
      account = scraper.query

      # e.g. $38.46
      expect(scraper.a_bill).to match(/\$\d*(?:\.\d+)?/)

      # e.g. 625
      expect(scraper.a_usage).to match(/\d*/)

      # Rely on the Date.parse() method to determine if string is remotely Date.
      expect(Date.parse(scraper.a_due_date).class).to eq(Date)
      expect(Date.parse(scraper.a_service_start).class).to eq(Date)
      expect(Date.parse(scraper.a_service_end).class).to eq(Date)
    end
  end
end
