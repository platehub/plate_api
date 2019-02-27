module PlateApi::PlateObject
  class Company < Base

    has_many :sites, :site, "PlateApi::PlateObject::Site"

    def initialize(id, attributes, relations, object_handler=nil)
      super(id, attributes, relations, object_handler)
    end

    def self.api_name
      "companies"
    end

    def self.parent_class
      Partner
    end
  end
end
