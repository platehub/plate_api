RSpec.describe PlateApi::Connector do

  let(:public_key) { "somepublickey" }
  let(:secret) { "somesecretsecret" }
  let(:test_path) { "/elements/12" }

  subject { described_class.new(public_key, secret) }

  describe "#get" do
    let(:request_object) { double(execute: "true")}

    it "creates a new instance of GetRequest" do
      allow(PlateApi::GetRequest).to receive(:new).and_return(request_object)
      expect(request_object).to receive(:execute)
      subject.get(test_path)
    end

    context "without parameters" do
      it "creates a new instance of GetRequest" do
        expect(PlateApi::GetRequest).to receive(:new).with(public_key, secret, test_path, {}, nil).and_return(request_object)
        subject.get(test_path)
      end
    end

    context "with parameters" do
      it "creates a new instance of GetRequest" do
        test_params = {test_param1: 123}
        expect(PlateApi::GetRequest).to receive(:new).with(public_key, secret, test_path, test_params, nil).and_return(request_object)
        subject.get(test_path, test_params)
      end
    end
  end

end
