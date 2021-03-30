RSpec.describe PlateApi::PostMultipartRequest do
  it_behaves_like "a request", described_class, :post

  before(:each) do
    @upload_file = File.new("spec/support/example_files/afile.txt")
    @request = described_class.new("public_key", "secret_key", "/sites/12/attachments", { file: @upload_file })
  end

  it "sends files in multipart request" do
    @request.execute
    expect(WebMock).to have_requested(:post, "https://www.startwithplate.com/api/v2/sites/12/attachments")
  end
end
