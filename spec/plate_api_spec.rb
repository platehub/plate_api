RSpec.describe PlateApi do
  it "has a version number" do
    expect(PlateApi::VERSION).not_to be nil
  end

  it "fails" do
    expect(1).to eq 2
  end 

end
