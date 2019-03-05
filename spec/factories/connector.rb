FactoryBot.define do
  factory :connector, class: "PlateApi::Connector" do
    secret {"somesecret"}
    public_key {"apublickey"}

    skip_create
    initialize_with { new(secret, public_key) }
  end

  factory :object_handler, class: "PlateApi::ObjectHandler" do
    connector {build(:connector)}
    handled_class {PlateApi::PlateObject::Site}

    skip_create
    initialize_with { new(handled_class, connector) }
  end
end
