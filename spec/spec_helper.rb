require 'rspec'
require 'webmock/rspec'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'ruby_engaging_networks'

RSpec.configure do |config|
  config.include WebMock::API

  config.before(:each) do
    WebMock.reset!
  end
  config.after(:each) do
    WebMock.reset!
  end

end

def stub_get(path)
  stub_action_kit_request(:get, path)
end

def stub_post(path)
  stub_action_kit_request(:post, path)
end

def stub_put(path)
  stub_action_kit_request(:put, path)
end

def stub_request(method, path)
  prefix = EngagingNetworks.new.connection.configuration.prefix.to_s
  stub_request(method, 'https://test.com' + prefix + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '/', file))
end