# Generate code coverage report.
require 'simplecov'
SimpleCov.start do
  add_filter 'spec'

  add_group 'lib', '/lib/'
end

# Add environment credentials to DOM login.
require 'dotenv'
Dotenv.load

# Capture HTTP payloads for faster testing.
# (and hopefully not DDOS Dominion...).
require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = false
  c.allow_http_connections_when_no_cassette = true
end
