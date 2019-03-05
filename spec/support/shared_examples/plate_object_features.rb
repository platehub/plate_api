RSpec.shared_examples "has parent_class" do |klass|
  it "has the parent_class #{klass}" do
    expect(described_class.parent_class).to eq klass
  end
end

RSpec.shared_examples "has api_name" do |name|
  it "has the api_name #{name}" do
    expect(described_class.api_name).to eq name
  end
end
