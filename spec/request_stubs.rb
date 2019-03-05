RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "https://www.startwithplate.com/api/v2/sites/12/posts").
             to_return(status: 200, body: {data: "Fake data"}.to_json, headers: {})
  end
end
