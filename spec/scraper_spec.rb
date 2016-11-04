#!/usr/bin/ruby

require_relative "../lib/scraper.rb"

describe "Scraper" do
  it "yields a message saying credentials are incorrect with bad username and password" do
    scraper = Scraper.new('user', 'pass');
    results = scraper.query

    expect(results).to eq('--> Something went wrong!  Maybe check your credentials?')
  end

  it "yields some valid results with correct credentials." do
    scraper = Scraper.new(ENV['DOM_USERNAME'], ENV['DOM_PASSWORD']);
    results = scraper.query

    # e.g. $38.46
    expect(results['bill']).to match(/\$\d*(?:\.\d+)?/)

    # e.g. 625
    expect(results['usage']).to match(/\d*/)

    # Rely on the Date.parse() method to determine if string is remotely Date.
    expect(Date.parse(results['due_date']).class).to eq(Date)
    expect(Date.parse(results['service_start']).class).to eq(Date)
    expect(Date.parse(results['service_end']).class).to eq(Date)

  end
end