module PlateApi::PlateObject
  class Company < Base

    has_one :partner, "PlateApi::PlateObject::Partner"
    has_many :sites, :site, "PlateApi::PlateObject::Site"

    def self.api_name
      "companies"
    end

    def self.parent_class
      Partner
    end
  end
end
