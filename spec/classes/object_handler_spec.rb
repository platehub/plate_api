RSpec.describe PlateApi::ObjectHandler do

  subject { described_class.new(PlateApi::PlateObject::Site, build(:connector)) }

  describe "#new" do
    context "without a handling_class" do
      it "raises an error" do
        expect{described_class.new(nil, build(:connector))}.to raise_error(ArgumentError)
      end
    end

    context "without a connector" do
      it "raises an error" do
        expect{described_class.new(PlateApi::PlateObject::Site, nil)}.to raise_error(ArgumentError)
      end
    end

    it "returns an instance of #{described_class}" do
      expect(described_class.new(PlateApi::PlateObject::Site, build(:connector))).to be_a described_class
    end
  end

  describe "#find" do
    context "with input only containing an id of an existing object" do

      context "with id that exists in Plate" do
        before(:each) do
          allow_any_instance_of(PlateApi::Connector).to receive(:get).with("sites/5").and_return(show_site_response(5))
        end

        it "returns a object of the handling_class of the subject" do
          expect(subject.find(5)).to be_a(PlateApi::PlateObject::Site)
        end

        it "returns a object with the correct id" do
          expect(subject.find(5).id).to eq 5
        end
      end

      context "with id that does not exist in Plate" do
        before(:each) do
          allow_any_instance_of(PlateApi::Connector).to receive(:get).with("sites/5").and_return(show_site_not_found_response(5))
        end

        it "returns nil" do
          expect(subject.find(5)).to be_nil
        end

      end
    end
  end

  describe "#create" do
    context "with input only containing an id of an existing object" do

      context "with id that exists in Plate" do
        before(:each) do
          @create_params = {
            name: "New Site Name",
            theme_id: 1
          }
          allow_any_instance_of(PlateApi::Connector).to receive(:post).with(
            "companies/1/sites",
            @create_params
          ).and_return(create_site_response(5))
        end

        it "returns a object of the handling_class of the subject" do
          expect(subject.create(5, @create_params)).to be_a(PlateApi::PlateObject::Site)
        end

        it "returns a object with the correct id" do
          expect(subject.create(5, @create_params).id).to eq 5
        end

        it "returns a object with the correct relations" do
          r = subject.create(5, @create_params)
          expect(r.theme).to be_a PlateApi::PlateObject::Theme
          expect(r.theme.id).to eq 1
          expect(r.company).to be_a PlateApi::PlateObject::Company
          expect(r.company.id).to eq 1
        end
      end

      context "with id that does not exist in Plate" do
        before(:each) do
          allow_any_instance_of(PlateApi::Connector).to receive(:get).with("sites/5").and_return(show_site_not_found_response(5))
        end

        it "returns nil" do
          expect(subject.find(5)).to be_nil
        end

      end
    end
  end

  describe "#update" do
    context "with valid input for an existing object" do

      context "with id that exists in Plate" do
        context "with valid update attributes" do
          before(:each) do
            allow_any_instance_of(PlateApi::Connector).to receive(:put).with(
              "sites/5",
              {"data" => {"name" => "A New Name"}}
            ).and_return(update_site_response(5, "A New Name"))
          end

          it "returns a object of the handling_class of the subject" do
            expect(subject.update(5, {"name" => "A New Name"})).to be_a(PlateApi::PlateObject::Site)
          end

          it "returns a object with the correct id" do
            expect(subject.update(5, {"name" => "A New Name"}).name).to eq "A New Name"
          end
        end

        context "with invalid update attributes" do
          before(:each) do
            allow_any_instance_of(PlateApi::Connector).to receive(:put).with(
              "sites/5",
              {"data" => {"name" => nil}}
            ).and_return(update_site_invalid_response(5))
          end

          it "returns nil" do
            expect(subject.update(5, {"name" => nil})).to be_nil
          end
        end
      end

      context "with id that does not exist in Plate" do
        before(:each) do
          allow_any_instance_of(PlateApi::Connector).to receive(:put).with(
            "sites/5",
            {"data" => {"name" => "A New Name"}}
          ).and_return(update_site_not_found_response(5))
        end

        it "returns nil" do
          expect(subject.update(5, {"name" => "A New Name"})).to be_nil
        end

      end
    end

  end
end
