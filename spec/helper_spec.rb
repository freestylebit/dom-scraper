#!/usr/bin/ruby

require_relative "../lib/helper.rb"

require "nokogiri"

describe Helper do
  before :each do
    # Mock some generic class to expose the module.
    @faux = Class.new.extend(Helper)

    # Prepare some sample HTML page for nokogiri to process.
    @html = Nokogiri::HTML('<html><body><div id="sample">Unicorn</div></body></html>')
  end

  it "parses Nokogiri DOM elements correctly into parse_text()" do
    expect(@faux.parse_text(@html.at('#sample'))).to eq('Unicorn')
  end

  it "yields a nil if the object passed into parse_text is not of type Nokogiri" do
    expect(@faux.parse_text(1234)).to eq('')
  end
end
