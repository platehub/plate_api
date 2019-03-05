RSpec.shared_examples "a PlateObject" do
  describe "#api_name" do
    it "returns .api_name" do
      expect(subject.api_name).not_to be_nil
      expect(subject.api_name).to eq described_class.api_name
    end
  end

  describe "#reload" do
    context "without @object_handler" do
      it "raises an error" do
        expect{subject.reload}.to raise_error(ArgumentError)
      end
    end

    context "with @object_handler" do
      before(:each) do
        @object_handler = build(:object_handler, handled_class: described_class)
        subject.object_handler = @object_handler
      end

      it "finds the object with same id through the object_handler" do
        expect(@object_handler).to receive(:find).with(subject.id).and_return(double(id: subject.id, attributes: subject.attributes, relations: subject.relations))
        subject.reload
      end

      it "updates new attributes and relations" do
        expect(subject.attributes["extra_key"]).to be_nil
        expect(subject.relations["extra_rel"]).to be_nil
        expect(@object_handler).to receive(:find).with(subject.id).and_return(
          double(
            id: subject.id, attributes: subject.attributes.merge("extra_key"=> 123), relations: subject.relations.merge("extra_rel"=> 456)
          )
        )
        subject.reload
        expect(subject.attributes["extra_key"]).to eq 123
        expect(subject.relations["extra_rel"]).to eq 456
      end
    end
  end

  describe "#inspect" do
    it "aliases to_s" do
      expect(subject.inspect).to eq subject.to_s
    end
  end

  describe "#to_s" do
    it "shows data of the object" do
      expect(subject.inspect).to include("Plate", "@id=#{subject.id}")
    end
  end

  describe "#method_missing" do
    context "with data in attributes hash" do
      it "graps data from the attributes hash" do
        object = described_class.new(12, {"param" => 12345}, {})
        expect(object.param).to eq 12345
      end

      it "graps data from the attributes[content] hash" do
        object = described_class.new(12, {"content"=>{"param" => {"value" => 123456}}}, {})
        expect(object.param).to eq 123456
      end
    end

    context "without data in attributes hash" do
      it "returns nil" do
        expect{subject.param}.to raise_error(NoMethodError)
      end
    end
  end

  describe "==" do
    it "returns true if id and class are the same" do
      expect(subject == subject).to be_truthy
    end

    it "returns false if id is the same but class differs" do
      expect(subject == double(id: subject.id)).to be_falsy
    end

    it "returns false if class is the same but id differs" do
      expect(subject == double(id: -1, class: subject.class)).to be_falsy
    end
  end

  describe "#update" do
    context "with no hash as input" do
      it "raises an error" do
        expect{subject.update(1234)}.to raise_error(ArgumentError)
      end
    end

    context "with no object_handler attached" do
      it "raises an error" do
        expect{subject.update({attr1: 123})}.to raise_error(ArgumentError)
      end
    end

    context "with hash input and attached object_handler" do
      before(:each) do
        @object_handler = build(:object_handler, handled_class: described_class)
        subject.object_handler = @object_handler
        @params = {update_attr: 123}
      end

      it "calls #update on the object_handler" do
        expect(@object_handler).to receive(:update).with(subject.id, @params).and_return(
          double(id: subject.id, attributes: subject.attributes, relations: subject.relations)
        )

        subject.update(@params)
      end

      it "updates new attributes as returned from the server" do
        expect(subject.attributes["extra_key"]).to be_nil
        expect(subject.relations["extra_rel"]).to be_nil
        expect(@object_handler).to receive(:update).with(subject.id, @params).and_return(
          double(
            id: subject.id, attributes: subject.attributes.merge("extra_key"=> 123), relations: subject.relations.merge("extra_rel"=> 456)
          )
        )
        subject.update(@params)
        expect(subject.attributes["extra_key"]).to eq 123
        expect(subject.relations["extra_rel"]).to eq 456
      end

      it "raises an error if object_handler#update returns nil" do
        expect(@object_handler).to receive(:update).with(subject.id, @params).and_return(
          nil
        )

        expect{subject.update(@params)}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#delete" do
    context "with no object_handler attached" do
      it "raises an error" do
        expect{subject.delete}.to raise_error(ArgumentError)
      end
    end

    context "with hash input and attached object_handler" do
      before(:each) do
        @object_handler = build(:object_handler, handled_class: described_class)
        subject.object_handler = @object_handler
      end

      it "calls #update on the object_handler" do
        expect(@object_handler).to receive(:delete).with(subject.id)

        subject.delete
      end
    end
  end
end
