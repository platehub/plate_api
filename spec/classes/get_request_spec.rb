RSpec.describe PlateApi::GetRequest do
  context "with default server" do
    describe "without parameters" do
      let(:get_request) { described_class.new("public_key", "secret_key", "sites/12/posts") }

      describe "without specified response type" do
        it "calls the Plate API" do
          get_request.execute
          expect(WebMock).to have_requested(:get, "https://www.startwithplate.com/api/v2/sites/12/posts")
        end

        it "returns raw response" do
          expect(get_request.execute).to eq "{\"data\":\"Fake data\"}"
        end
      end

      describe "with specified response type" do
        it "returns hash response" do
          expect(get_request.execute(:json)).to eq ({"data" => "Fake data"})
        end
      end
    end
  end
end
