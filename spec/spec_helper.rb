require 'simplecov'
require 'simplecov-console'


SimpleCov.start do
  add_filter "/spec"
end

require "bundler/setup"
require "plate_api"
require "factory_bot"
require "utils/example_api_responses"
require 'byebug'
require 'webmock/rspec'

require 'request_stubs'


WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include ExampleApiResponses
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end


  # FactoryBot setup
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

end
