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

  describe "#delete" do
    let(:request_object) { double(execute: "true")}

    it "creates a new instance of GetRequest" do
      allow(PlateApi::DeleteRequest).to receive(:new).and_return(request_object)
      expect(request_object).to receive(:execute)
      subject.delete(test_path)
    end
  end

  describe "#post" do
    let(:request_object) { double(execute: "true")}

    it "creates a new instance of GetRequest" do
      allow(PlateApi::PostRequest).to receive(:new).and_return(request_object)
      expect(request_object).to receive(:execute)
      subject.post(test_path)
    end
  end

  describe "#put" do
    let(:request_object) { double(execute: "true")}

    it "creates a new instance of GetRequest" do
      allow(PlateApi::PutRequest).to receive(:new).and_return(request_object)
      expect(request_object).to receive(:execute)
      subject.put(test_path)
    end
  end

  describe "#post_multipart" do
    let(:request_object) { double(execute: "true")}

    it "creates a new instance of GetRequest" do
      allow(PlateApi::PostMultipartRequest).to receive(:new).and_return(request_object)
      expect(request_object).to receive(:execute)
      subject.post_multipart(test_path)
    end
  end

  describe "#handler" do
    it "returns an object_handler" do
      expect(subject.handler(PlateApi::PlateObject::Site)).to be_a PlateApi::ObjectHandler
    end

    it "returns an object_handler with the handled class" do
      expect(subject.handler(PlateApi::PlateObject::Site).handling_class).to eq PlateApi::PlateObject::Site
    end
  end

  describe "handler templates" do
    describe "sites" do
      it "returns an object_handler" do
        expect(subject.sites).to be_a PlateApi::ObjectHandler
      end

      it "returns an object_handler with the handled class" do
        expect(subject.sites.handling_class).to eq PlateApi::PlateObject::Site
      end
    end
  end

end
