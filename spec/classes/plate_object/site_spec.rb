RSpec.describe PlateApi::PlateObject::Site do

  describe "#new" do
    context "without name in the attributes argument" do
      it "raises an error" do
        expect{described_class.new(1, {})}.to raise_error(ArgumentError)
      end
    end

    it "returns an instance of #{described_class}" do
      expect(described_class.new(1, {"name" => "A Name"})).to be_a described_class
    end
  end

  describe "#name" do
    subject { described_class.new(1, {"name" => "My Name"})}
    it "returns name as set in the attributes" do
      expect(subject.name).to eq "My Name"
    end
  end


end
