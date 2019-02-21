FactoryBot.define do
  factory :connector, class: "PlateApi::Connector" do
    secret {"somesecret"}
    public_key {"apublickey"}

    skip_create
    initialize_with { new(secret, public_key) }

  end
end
