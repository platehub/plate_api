RSpec.describe PlateApi::PlateObject::Site do

  it_behaves_like "a PlateObject" do
    let(:subject) { described_class.new(1, {"name" => "A Name"}, {}) }
  end

  describe "#new" do
    it "returns an instance of #{described_class}" do
      expect(described_class.new(1, {"name" => "A Name"}, {})).to be_a described_class
    end
  end

  describe "#name" do
    subject { described_class.new(1, {"name" => "My Name"}, {})}
    it "returns name as set in the attributes" do
      expect(subject.name).to eq "My Name"
    end
  end

  include_examples("has parent_class", PlateApi::PlateObject::Company)
  include_examples("has api_name", "sites")

  # TODO: Create specs for relations
  # include_examples("has has_many relation", :posts) do
  #   let(:subject) { described_class.new(1, {"name" => "A Name"}, {}) }
  # end
end
