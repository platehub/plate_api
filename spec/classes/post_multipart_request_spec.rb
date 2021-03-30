RSpec.describe PlateApi::PostMultipartRequest do
  it_behaves_like "a request", described_class, :post

  before(:each) do
    @upload_file = File.new("spec/support/example_files/sample.txt")
    @request = described_class.new("public_key", "secret_key", "/sites/12/attachments", { file: @upload_file })
  end

  it "sends files in multipart request" do
    @request.execute
    expect(WebMock).to have_requested(:post, "https://www.startwithplate.com/api/v2/sites/12/attachments")
  end

  it "correctly determines the mime_type of a pdf file" do
    file = File.new("spec/support/example_files/sample.pdf")
    path = File.expand_path(file)

    expect(@request.mime_type(path)).to eq("application/pdf")
  end

  it "correctly determines the mime_type of a txt file" do
    path = File.expand_path(@upload_file)

    expect(@request.mime_type(path)).to eq("text/plain")
  end

  it "correctly determines the mime_type of a JFIF file" do
    file = File.new("spec/support/example_files/sample.jfif")
    path = File.expand_path(file)

    expect(@request.mime_type(path)).to eq("image/jpeg")
  end

  it "correctly determines the mime_type of a JPG file" do
    file = File.new("spec/support/example_files/sample.jpg")
    path = File.expand_path(file)

    expect(@request.mime_type(path)).to eq("image/jpeg")
  end

  it "correctly determines the mime_type of a PNG file" do
    file = File.new("spec/support/example_files/sample.png")
    path = File.expand_path(file)

    expect(@request.mime_type(path)).to eq("image/png")
  end
end
