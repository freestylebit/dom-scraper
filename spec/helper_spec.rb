#!/usr/bin/ruby

load "lib/helper.rb"

# Generate code coverage report.
require 'simplecov'
SimpleCov.start

describe "Helper" do
  before :each do
    # Mock some generic class to expose the module.
    @faux = Class.new.extend(Helper)

    # Prepare some sample HTML page for nokogiri to process.
    @html = Nokogiri::HTML('<html><body><div id="sample">Unicorn</div></body></html>')
  end

  it "parses nokogiri DOM elements correctly" do
    expect(@faux.parse_text(@html.at('#sample'))).to eq('Unicorn')
  end
end
