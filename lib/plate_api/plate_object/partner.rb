module PlateApi::PlateObject
  class Partner < Base

    has_many :companies, :company, "PlateApi::PlateObject::Company"

    def initialize(id, attributes, relations, object_handler=nil)
      super(id, attributes, relations, object_handler)
    end

    def self.api_name
      "partners"
    end

    def self.parent_class
      Partner
    end
  end
end
