RSpec.shared_examples "a request" do |klass, request_method|
  context "with default server" do
    context "without parameters" do
      let(:request) { klass.new("public_key", "secret_key", "sites/12/posts") }

      context "without specified response type" do
        it "calls the Plate API" do
          request.execute
          expect(WebMock).to have_requested(request_method, "https://www.startwithplate.com/api/v2/sites/12/posts")
        end

        it "returns raw response" do
          expect(request.execute).to eq "{\"data\":\"Fake data\"}"
        end
      end

      context "with specified response type" do
        it "returns hash response" do
          expect(request.execute(:json)).to eq ({"data" => "Fake data"})
        end
      end
    end
  end

  context "with custom server" do
    let(:request) { klass.new("public_key", "secret_key", "sites/12/posts", {}, "http://www.custom-server.plate") }
    it "sends request to a custom server" do
      request.execute
      expect(WebMock).to have_requested(request_method, "http://www.custom-server.plate/sites/12/posts")
    end
  end
end
