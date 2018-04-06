require 'rspec'
require 'lingo_kids'

Rspec.configure do |config|
  config.expect_with do |c|
    c.syntax = :expect
  end
end
