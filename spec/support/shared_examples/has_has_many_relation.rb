RSpec.shared_examples "has has_many relation" do |relation_name|
  before(:each) do
    @object_handler = build(:object_handler, handled_class: described_class)
    subject.object_handler = @object_handler
  end

  describe "##{relation_name}" do
    it "returns correct #{relation_name}" do
      stub_request(
        :any,
        "https://www.startwithplate.com/api/v2/sites/#{subject.id}/#{relation_name}"
      ).to_return(status: 200, body: { data: "Fake data" }.to_json, headers: {})

      subject.send(relation_name)
    end
  end

  # describe "#all_#{relation_name}" do
  # end
end