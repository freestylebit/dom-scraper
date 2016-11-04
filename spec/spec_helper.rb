# Generate code coverage report.
require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_group 'lib', '/lib/'
end

# Add environment credentials to DOM login.
require 'dotenv'
Dotenv.load