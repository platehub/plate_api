RSpec.describe PlateApi::PlateObject::Section do

  it_behaves_like "a PlateObject" do
    let(:subject) { described_class.new(1, {"name" => "A Name"}, {}) }
  end

  include_examples("has parent_class", PlateApi::PlateObject::Post)
  include_examples("has api_name", "sections")


end
