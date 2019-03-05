RSpec.describe PlateApi::GetRequest do
  it_behaves_like "a request", described_class, :get

  context "with parameters" do
    let(:get_request) { described_class.new("public_key", "secret_key", "sites/12/posts", {param1: 123, aparam: "early"}) }

    it "adds params as query parameters, sorted alphabetically by key" do
      get_request.execute
      expect(WebMock).to have_requested(:get, "https://www.startwithplate.com/api/v2/sites/12/posts?aparam=early&param1=123")
    end
  end

  context "with custom server" do
    let(:get_request) { described_class.new("public_key", "secret_key", "sites/12/posts", {}, "http://www.custom-server.plate") }
    it "sends request to a custom server" do
      get_request.execute
      expect(WebMock).to have_requested(:get, "http://www.custom-server.plate/sites/12/posts")
    end
  end
end
