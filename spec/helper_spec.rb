#!/usr/bin/ruby

load "lib/helper.rb"

describe "Helper" do
  before :each do
    let(:helper) { Class.new { include Helper } }
  end

  it "parses nokogiri DOM elements correctly" do
  end
end
