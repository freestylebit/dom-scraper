#!/usr/bin/ruby

load "lib/helper.rb"

describe "Helper" do
  before :each do
    # Mock some generic class to expose the module.
    @faux = Class.new { include Helper }
  end

  it "parses nokogiri DOM elements correctly" do
  end
end
